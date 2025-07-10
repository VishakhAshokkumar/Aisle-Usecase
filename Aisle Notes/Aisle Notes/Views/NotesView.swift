//
//  NotesView.swift
//  Aisle Notes
//
//  Created by Vishak on 09/07/25.
//

import UIKit


class NotesView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.font = UIFont.gilroyBlack(size: 28)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subheadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Personal messages to you"
        label.font = UIFont.gilroyRegular(size: 17)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let nameAgeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroyBlack(size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let reviewNotesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gilroyBlack(size: 14)
        label.textColor = .white
        label.text = "Tap to review 50+ notes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let interestedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Interested In You"
        label.font = UIFont.gilroyBlack(size: 22)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let interestedSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Premium members can view all their likes at once"
        label.font = UIFont.gilroyRegular(size: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let upgradeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upgrade", for: .normal)
        button.backgroundColor = .aisleYellow
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.gilroyBlack(size: 15)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 200)
        layout.minimumLineSpacing = 12

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }


    private func setupViews() {
        let headerStackView = UIStackView(arrangedSubviews: [titleLabel, subheadingLabel])
        headerStackView.axis = .vertical
        headerStackView.spacing = 4
        headerStackView.alignment = .center
        headerStackView.translatesAutoresizingMaskIntoConstraints = false

        let interestedTextStack = UIStackView(arrangedSubviews: [interestedTitleLabel, interestedSubtitleLabel])
        interestedTextStack.axis = .vertical
        interestedTextStack.spacing = 4
        interestedTextStack.alignment = .leading
        interestedTextStack.translatesAutoresizingMaskIntoConstraints = false

        let bottomStackView = UIStackView(arrangedSubviews: [interestedTextStack, upgradeButton])
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 12
        bottomStackView.alignment = .center
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(headerStackView)
        addSubview(profileImageView)
        addSubview(bottomStackView)
        addSubview(collectionView)

        profileImageView.addSubview(overlayView)
        overlayView.addSubview(nameAgeLabel)
        overlayView.addSubview(reviewNotesLabel)

        // Save the stacks as properties for constraints
        self.headerStackView = headerStackView
        self.bottomStackView = bottomStackView
    }

    private var headerStackView: UIStackView!
    private var bottomStackView: UIStackView!

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            headerStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            profileImageView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            profileImageView.heightAnchor.constraint(equalToConstant: 300),

            overlayView.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            overlayView.heightAnchor.constraint(equalToConstant: 80),

            nameAgeLabel.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 12),
            nameAgeLabel.bottomAnchor.constraint(equalTo: reviewNotesLabel.topAnchor, constant: -4),

            reviewNotesLabel.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 12),
            reviewNotesLabel.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -8),

            bottomStackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

            upgradeButton.widthAnchor.constraint(equalToConstant: 100),
            upgradeButton.heightAnchor.constraint(equalToConstant: 40),

            collectionView.topAnchor.constraint(equalTo: bottomStackView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            collectionView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}

