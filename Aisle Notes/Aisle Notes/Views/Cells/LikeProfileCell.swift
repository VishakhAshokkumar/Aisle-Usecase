//
//  LikeProfileCell.swift
//  Aisle Notes
//
//  Created by Vishak on 09/07/25.
//

import UIKit

class LikeProfileCell: UICollectionViewCell {
    static let identifier = "LikeProfileCell"

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 12
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroyBlack(size: 16)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        imageView.addSubview(blurView)          // Add blurView to imageView here!
        blurView.contentView.addSubview(nameLabel) // Add label inside blurView’s contentView

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            blurView.topAnchor.constraint(equalTo: imageView.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor, constant: -12),
            nameLabel.bottomAnchor.constraint(equalTo: blurView.contentView.bottomAnchor, constant: -12),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true

        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true

        blurView.layer.cornerRadius = 12
        blurView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    func configure(with profile: Like) {
        nameLabel.text = profile.first_name
        guard let url = URL(string: profile.avatar) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data),
                  error == nil else { return }

            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }.resume()
    }
}
