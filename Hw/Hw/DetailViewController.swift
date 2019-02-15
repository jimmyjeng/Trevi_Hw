//
//  DetailViewController.swift
//  Hw
//
//  Created by rex on 2019/2/16.
//  Copyright © 2019年 Jimmy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var randomCollectionView: UICollectionView!
    
    private var colCount:Int = 0
    private var rowCount:Int = 0
    private var checkTimer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        checkTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
           // print("### checkTimer")
        })

    }
    
    deinit {
        checkTimer?.invalidate()
    }
    
    func setData(column:Int, row:Int) {
        colCount = column
        rowCount = row
    }
}
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colCount * (rowCount + 1)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "randomCell", for: indexPath)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: randomCollectionView.frame.width/CGFloat(colCount) , height: randomCollectionView.frame.height/CGFloat(rowCount + 1) )
        return cellSize
    }
}
