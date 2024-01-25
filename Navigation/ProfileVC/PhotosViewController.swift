//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 14.12.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    // MARK: - Properties
    
    private enum Constants {
        static let photoSpacing: CGFloat = 8
    }
    let facade = ImagePublisherFacade()
    
    // MARK: -  Data
    
    fileprivate let userData = User.make()
    private var userPhotos: [UIImage] = []
    
    // MARK: - SubViews
    
    private lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let photoSize = (view.frame.width - Constants.photoSpacing * 4)/3
        layout.itemSize = CGSize(width: photoSize, height: photoSize)
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        photosCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseID)
        return  photosCollectionView
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tuneView()
        addSubviews()
        setupConstraints()
        collectionView()
        facade.subscribe(self)
        facade.addImagesWithTimer(time: 1, repeat: 20, userImages: userData.photos)
    }
    
    // MARK: - Private
    
    private func tuneView() {
        view.backgroundColor = .white
        title = "Photo Gallery"
        navigationController?.navigationBar.isHidden = false
    }
    
    private func collectionView() {
        photosCollectionView.dataSource = self
    }
    
    private func addSubviews() {
        view.addSubview(photosCollectionView)
    }
    
    private func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let photosCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.reuseID,
            for: indexPath) as? PhotosCollectionViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        photosCell.setupData(image: userPhotos[indexPath.row])
        
        return photosCell
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        userPhotos = images
        photosCollectionView.reloadData()
        print("image added")
    }
}
