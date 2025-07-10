//
//  NotesViewController.swift
//  Aisle Notes
//
//  Created by Vishak on 08/07/25.
//

import UIKit


class NotesViewController: UIViewController {

    var notes: NotesResponse?
    private let imageCache = NSCache<NSString, UIImage>()
    private var likedProfiles: [Like] = []

    private let notesView = NotesView()

    override func loadView() {
        self.view = notesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        view.backgroundColor = .systemBackground

        configureContent()
    }
    
    private func configureCollectionView(){
        notesView.collectionView.delegate = self
        notesView.collectionView.dataSource = self

        // Register the cell class here
        notesView.collectionView.register(LikeProfileCell.self, forCellWithReuseIdentifier: LikeProfileCell.identifier)
    }


    private func configureContent() {
        if let profile = notes?.invites?.profiles.first,
           let age = profile.generalInformation.age {
            let firstName = profile.generalInformation.firstName
            notesView.nameAgeLabel.text = "\(firstName), \(age)"
        }

        likedProfiles = notes?.likes?.profiles ?? []
        notesView.collectionView.reloadData()

        loadProfileImage()
    }

    private func loadProfileImage() {
        guard let photos = notes?.invites?.profiles.first?.photos,
              let additionalPhoto = photos.first(where: { $0.selected != true }),
              let imageUrl = URL(string: additionalPhoto.photo) else { return }

        loadImage(from: imageUrl, into: notesView.profileImageView)
    }

    private func loadImage(from url: URL, into imageView: UIImageView) {
        let cacheKey = NSString(string: url.absoluteString)

        if let cachedImage = imageCache.object(forKey: cacheKey) {
            imageView.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data),
                  error == nil else { return }

            self.imageCache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }
}

// MARK: - UICollectionViewDelegate & DataSource

extension NotesViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedProfiles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeProfileCell.identifier, for: indexPath) as? LikeProfileCell else {
            return UICollectionViewCell()
        }
        let profile = likedProfiles[indexPath.item]
        cell.layer.masksToBounds = true
        cell.configure(with: profile)
        return cell
    }
}
