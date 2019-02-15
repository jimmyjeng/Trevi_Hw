//
//  DetailViewController.swift
//  Hw
//
//  Created by Jimmy on 2019/2/16.
//  Copyright © 2019年 Jimmy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var randomCollectionView: UICollectionView!
    
    private var colCount:Int = 0
    private var rowCount:Int = 0
    private var checkTimer:Timer?
    private var selectedNum = -1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        weak var weakSelf = self
        checkTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (Timer) in
            weakSelf?.randomSelect()
        })
    }
    
    deinit {
        checkTimer?.invalidate()
    }
    
    func setData(column:Int, row:Int) {
        colCount = column
        rowCount = row
    }
    
    func randomSelect() {
        let temp = Int.random(in: 0..<(colCount * rowCount))
        if ((colCount * rowCount) != 1) {
            guard selectedNum != temp else {
                randomSelect()
                return
            }
        }
        selectedNum = temp
        randomCollectionView.reloadData()
    }
    
    @objc func clearRandom() {
        selectedNum = -1
        randomCollectionView.reloadData()
    }
}
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colCount * (rowCount + 1)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row < colCount * rowCount) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "randomCell", for: indexPath) as! RandomCollectionViewCell
            cell.randomLabel.isHidden = (indexPath.row != selectedNum)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as! ButtonCollectionViewCell
            cell.okButton.addTarget(self, action: #selector(clearRandom), for: .touchUpInside)
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: randomCollectionView.frame.width/CGFloat(colCount) , height: randomCollectionView.frame.height/CGFloat(rowCount + 1) )
        return cellSize
    }
}
