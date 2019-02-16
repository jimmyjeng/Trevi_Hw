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
    private var colorArray:[UIColor]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        weak var weakSelf = self
        checkTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (Timer) in
            weakSelf?.randomSelect()
        })
    }
    
    deinit {
        checkTimer?.invalidate()
    }
    
    func setData(column:Int, row:Int) {
        colCount = column
        rowCount = row
        colorArray = [UIColor]()
        for _ in 0..<rowCount {
            colorArray?.append(UIColor.random)
        }
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
    
    func isSelectColumn(row:Int) -> Bool {
        return (selectedNum % colCount == row % colCount)
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
            
            let line = indexPath.row / colCount
            cell.topView.backgroundColor = colorArray?[line]
            cell.bottomView.backgroundColor = colorArray?[line].darker()
            
            if (isSelectColumn(row: indexPath.row)) {
                cell.backgroundColor = UIColor.blue
            } else {
                cell.backgroundColor = UIColor.clear
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as! ButtonCollectionViewCell
            cell.okButton.addTarget(self, action: #selector(clearRandom), for: .touchUpInside)
            
            if (isSelectColumn(row: indexPath.row)) {
                cell.backgroundColor = UIColor.blue
                cell.okButton.backgroundColor = UIColor.blue
            } else {
                cell.backgroundColor = UIColor.black
                cell.okButton.backgroundColor = UIColor.clear
            }
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: randomCollectionView.frame.width/CGFloat(colCount) , height: randomCollectionView.frame.height/CGFloat(rowCount + 1) )
        return cellSize
    }
}
