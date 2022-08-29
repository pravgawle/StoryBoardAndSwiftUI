//
//  Copyright © Pravin G. All rights reserved.
//

import UIKit
import SwiftUI

class PopularMoviesViewController: UICollectionViewController {
	
	var viewModel = PopularMoviesViewModel()
	
	struct Constants {
		static let cellReuseIdentifier: String = "PopularMovieCell"
	}
	
	init() {
		super.init(collectionViewLayout: layout)
	}
	
	private var layout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 1
		layout.minimumInteritemSpacing = 1
		layout.scrollDirection = .vertical
		layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
		return layout
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Popular"
		
		self.collectionView.register(PopularMovieCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateMoviesList()
	}
	
	private func updateMoviesList() {
		viewModel.fetchData { [weak self] (result) in
			guard let self = self else { return }
			if case .success(_) = result {
				DispatchQueue.main.async {
					self.collectionView.reloadData()
				}
			} else {
				self.showAlert(title: "Something Went Wrong!", message: "")
			}
		}
	}

	private func showAlert(title: String, message: String) {
			let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
			self.present(alert, animated: true, completion: nil)
	}
	
	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - UICollectionView Data Source & Delegate

extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.movies?.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseIdentifier, for: indexPath) as? PopularMovieCell,
					let movies = viewModel.movies	else {
			return UICollectionViewCell()
		}
		cell.summary = movies[indexPath.row]
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cellWidth = collectionView.frame.size.width/2 - 3.0
		return CGSize(width: (cellWidth), height: (cellWidth) * 1.5)
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("didSelectItemAt")
	}
}
