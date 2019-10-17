//
//  MainViewController.swift
//  Carousel
//
//  Created by Alexey Zhulikov on 11/10/2019.
//  Copyright © 2019 Alexey Zhulikov. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Private Properties

    private var actions = [
        Action(title: "Пополните кошелек", iconName: "dollar"),
        Action(title: "Выпустите виртуальную карту", iconName: "credit-card"),
        Action(title: "Сделайте первый платеж", iconName: "shopping-cart"),
        Action(title: "Начните получать кэшбэк баллами", iconName: "ticket")
    ]
    private var discounts = [
        Discount(title: "Кэшбэк 1.53%", description: "За авиабилеты", backgroundImageName: "air"),
        Discount(title: "Кэшбэк 5%", description: "За билеты по Европе", backgroundImageName: "europe"),
        Discount(title: "Кэшбэк до 10%", description: "За покупку одежды", backgroundImageName: "wear"),
        Discount(title: "10%", description: "Скидка на билеты в кино", backgroundImageName: "cinema"),
        Discount(title: "Кэшбэк 3%", description: "KFC", backgroundImageName: "kfc"),
    ]

    private var actionsDataSource: CollectionViewDataSource<Action>?
    private var discountsDataSource: InfiniteCollectionViewDataSource<Discount>?

    // MARK: - Subviews

    @IBOutlet private weak var actionsCollectionView: UICollectionView!
    @IBOutlet private weak var discountsCollectionView: UICollectionView!
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }

}

// MARK: - Private Configuration

private extension MainViewController {

    func configureAppearance() {
        configureActionsCollectionView()
        configureDiscountsCollectionView()
    }

    func configureActionsCollectionView() {
        actionsCollectionView.showsVerticalScrollIndicator = false
        actionsCollectionView.showsHorizontalScrollIndicator = false
        actionsCollectionView.backgroundColor = .clear
        actionsCollectionView.decelerationRate = .fast
        actionsCollectionView.collectionViewLayout = LeftedFlowLayout()
        actionsCollectionView.register(ActionCell.self)

        actionsDataSource = CollectionViewDataSource(data: actions, cellClass: ActionCell.self) { action, cell in
            guard let cell = cell as? ActionCell else {
                return
            }
            cell.configure(title: action.title, icon: action.icon)
        }
        actionsCollectionView.dataSource = actionsDataSource
    }

    func configureDiscountsCollectionView() {
        discountsCollectionView.showsVerticalScrollIndicator = false
        discountsCollectionView.showsHorizontalScrollIndicator = false
        discountsCollectionView.backgroundColor = .clear
        discountsCollectionView.decelerationRate = .fast
        discountsCollectionView.collectionViewLayout = CenteredFlowLayout()
        discountsCollectionView.register(DiscountCell.self)

        discountsDataSource = InfiniteCollectionViewDataSource(
            data: discounts,
            cellClass: DiscountCell.self
        ) { discount, cell in
            guard let cell = cell as? DiscountCell else {
                return
            }
            cell.configure(title: discount.title, description: discount.description, image: discount.backgroundImage)
        }
        discountsCollectionView.dataSource = discountsDataSource
        DispatchQueue.main.async {
            self.discountsCollectionView.scrollToItem(
                at: IndexPath(item: 500, section: 0),
                at: .centeredHorizontally,
                animated: false
            )
        }
    }

}
