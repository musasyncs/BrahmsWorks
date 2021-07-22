//
//  ViewController.swift
//  BrahmsWorks
//
//  Created by Ewen on 2021/7/22.
//

import UIKit
class ViewController: UIViewController {
    let worksImageArray = ["sym1","sym2","sym3","sym4"]
    let worksNameArray = ["Symphony No. 1 in C minor, Op. 68","Symphony No. 2 in D major, Op. 73","Symphony No. 3 in F major, Op. 90","Symphony No. 4 in E minor, Op. 98"]
    let pageArray = ["1","2","3","4"]
    let introArray = [
        "The Symphony No. 1 in C minor, Op. 68, is a symphony written by Johannes Brahms. Brahms spent at least fourteen years completing this work, whose sketches date from 1854. Brahms himself declared that the symphony, from sketches to finishing touches, took 21 years, from 1855 to 1876. The premiere of this symphony, conducted by the composer's friend Felix Otto Dessoff, occurred on 4 November 1876, in Karlsruhe, then in the Grand Duchy of Baden. A typical performance lasts between 45 and 50 minutes.",
        "Symphony No. 2 in D major, Op. 73, was composed by Johannes Brahms in the summer of 1877, during a visit to Pörtschach am Wörthersee, a town in the Austrian province of Carinthia. Its composition was brief in comparison with the 21 years it took Brahms to complete his First Symphony.",
        "Symphony No. 3 in F major, Op. 90, is a symphony by Johannes Brahms. The work was written in the summer of 1883 at Wiesbaden, nearly six years after he completed his Symphony No. 2. In the interim Brahms had written some of his greatest works, including the Violin Concerto, two overtures (Tragic Overture and Academic Festival Overture), and Piano Concerto No. 2.",
        "The Symphony No. 4 in E minor, Op. 98 by Johannes Brahms is the last of his symphonies. Brahms began working on the piece in Mürzzuschlag, then in the Austro-Hungarian Empire, in 1884, just a year after completing his Symphony No. 3. It was premiered on October 25, 1885 in Meiningen, Germany."
    ]
    
    var num: Int = 0
    
    @IBOutlet weak var worksImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var worksLabel: UILabel!
    @IBOutlet weak var introTextView: UITextView!
    @IBOutlet weak var autoPlayBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        worksImageView.image = UIImage(named: worksImageArray[0])
        worksImageView.layer.cornerRadius = 10
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        pageLabel.text = pageArray[0]
        worksLabel.text = worksNameArray[0]
        introTextView.text = introArray[0]
    }
    
    // 同步修改
    func sync() {
        worksImageView.image = UIImage(named: worksImageArray[num])
        
        pageControl.currentPage = num
        segmentControl.selectedSegmentIndex = num
        
        pageLabel.text = pageArray[num]
        worksLabel.text = worksNameArray[num]
        introTextView.text = introArray[num]
    }
    
    // page control 換頁
    @IBAction func pageChange(_ sender: UIPageControl) {
        num = sender.currentPage
        if pageControl.currentPage == 0 {
            num = 0
            sync()
        } else if pageControl.currentPage == 1 {
            num = 1
            sync()
        } else if pageControl.currentPage == 2 {
            num = 2
            sync()
        } else {
            num = 3
            sync()
        }
    }
    
    // segmented control 換頁
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        num = sender.selectedSegmentIndex
        if segmentControl.selectedSegmentIndex == 0 {
            num = 0
            sync()
        } else if segmentControl.selectedSegmentIndex == 1 {
            num = 1
            sync()
        } else if segmentControl.selectedSegmentIndex == 2 {
            num = 2
            sync()
        } else {
            num = 3
            sync()
        }
    }
    
    // 按鈕換頁
    @IBAction func PreviousBtn(_ sender: Any) {
        num -= 1
        if num == -1 {
            num = 3
            sync()
        } else {
            sync()
        }
    }
    @IBAction func nextBtn(_ sender: Any) {
        num += 1
        if num == 4 {
            num = 0
            sync()
        } else {
            sync()
        }
    }
    
    // 手勢換頁
    @IBAction func swipeChange(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            num -= 1
            if num == -1 {
                num = 3
                sync()
            } else {
                sync()
            }
        } else if sender.direction == .left {
            num += 1
            if num == 4 {
                num = 0
                sync()
            } else {
                sync()
            }
        }
    }

    
    //長按圖片隨機換頁
    @IBAction func showRandom(_ sender: UILongPressGestureRecognizer) {
        let randomNum = Int.random(in: 0 ... pageArray.count - 1)
        num = randomNum
        sync()
    }
    
    
    //輪播
    var timer: Timer?
    
    @IBAction func autoPlay(_ sender: UIButton) {
        if sender.titleLabel?.text == "Auto Play" {
            autoPlayBtn.setTitle("Stop", for: UIControl.State.normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startCarousell), userInfo: nil, repeats: true)
        } else {
            autoPlayBtn.setTitle("Auto Play", for: UIControl.State.normal)
            timer?.invalidate()
        }
    }
    
    @objc func startCarousell() {
        num += 1
        if num == 4 {
            num = 0
            sync()
        } else {
            sync()
        }
    }
}
