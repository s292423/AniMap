//
//  VideoViewController.swift
//  imgscroll
//
//  Created by 謝忠穎 on 2017/6/29.
//  Copyright © 2017年 謝忠穎. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Firebase

class VideoViewController: UIViewController,
    UICollectionViewDelegate,
UICollectionViewDataSource {
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    var secc :UIScrollView!
    private var videoURL: URL
    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    var fullscreen : CGRect?
    var blackview :UIView?
    let layout = UICollectionViewFlowLayout()
    var mycollectionView :UICollectionView?
    
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // init full screen
        fullscreen = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        
        
        self.view.backgroundColor = UIColor.gray
        player = AVPlayer(url: videoURL)
        playerController = AVPlayerViewController()
        
        guard player != nil && playerController != nil else {
            return
        }
        playerController!.showsPlaybackControls = false
        
        playerController!.player = player!
        self.addChildViewController(playerController!)
        self.view.addSubview(playerController!.view)
        playerController!.view.frame = view.frame
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
        
        scrollviewInit()
        //stickerinit
        initCollectionview()
        
        let cancelButton = UIButton(frame: CGRect(x: 15.0, y: 15.0, width: 30.0, height: 30.0))
        cancelButton.setImage(#imageLiteral(resourceName: "cancel"), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        let stickerButton = UIButton(frame: CGRect(x: (fullscreen?.width)! - 40, y: 10.0, width: 30.0, height: 30.0))
        stickerButton.setImage(#imageLiteral(resourceName: "cancel"), for: UIControlState())
        stickerButton.addTarget(self, action: #selector(addstickerView), for: .touchUpInside)
        
        let sendbutton = UIButton(frame: CGRect(x: (fullscreen?.width)! - 90, y: (fullscreen?.height)! - 60, width: 80, height: 35))
        sendbutton.setImage(#imageLiteral(resourceName: "send"), for: UIControlState())
        sendbutton.addTarget(self, action: #selector(uploadvideo), for: .touchUpInside)
        
//        let test = UIButton(frame: CGRect(x: 90, y: (fullscreen?.height)! - 60, width: 80, height: 35))
//        test.setImage(#imageLiteral(resourceName: "send"), for: UIControlState())
//        test.addTarget(self, action: #selector(test132), for: .touchUpInside)
//        
//        view.addSubview(test)

        view.addSubview(stickerButton)
        view.addSubview(sendbutton)
        view.addSubview(cancelButton)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player?.play()
    }
    
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player!.seek(to: kCMTimeZero)
            self.player!.play()
        }
    }
    
    func initCollectionview(){
        
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        layout.minimumLineSpacing = 15
        
        layout.itemSize = CGSize(width:  CGFloat((fullscreen?.width)!)/5 - 13, height: CGFloat((fullscreen?.width)!)/5 - 13)
        
        // init collectionview
        mycollectionView = UICollectionView(frame: CGRect(x: 0, y: (fullscreen?.height)!, width: (fullscreen?.width)!, height: (fullscreen?.width)!), collectionViewLayout: layout)
        
        mycollectionView?.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        mycollectionView?.delegate = self as UICollectionViewDelegate
        mycollectionView?.dataSource = self as UICollectionViewDataSource
        mycollectionView?.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        
        self.view.addSubview(mycollectionView!)
    }
    
    
    func test132(){
         //dismiss(animated: true, completion: nil)
        
        let thisCV: UIViewController! = self
//
//        self.dismiss(animated: false) {
//            // go back to MainMenuView as the eyes of the user
//            thisCV.dismiss(animated: false, completion: nil)
//        }
        
        let url = NSURL(string: "https://firebasestorage.googleapis.com/v0/b/animap-3b23e.appspot.com/o/test.mov?alt=media&token=3b6dd74f-04ae-46f6-bc2b-0916a466a6e4")! as URL
        let vc = TestingViewController(videoURL: "https://firebasestorage.googleapis.com/v0/b/animap-3b23e.appspot.com/o/test.mov?alt=media&token=17bc1ef5-bb78-472c-a3c9-8a5039b1b93b")
        
        self.dismiss(animated: true, completion: nil)
        
        thisCV.present(vc, animated: true, completion: nil)
        
        
        
    }
    
    func cancel() {
        
        dismiss(animated: true, completion: nil)        
    }
    
    func uploadvideo(){
        let filename = "test.mov"
        let storage = Storage.storage().reference()
        print(videoURL)
        
        let mask  = UIView(frame: fullscreen!)
        mask.backgroundColor = UIColor(white: 0, alpha: 0.7)
        mask.isUserInteractionEnabled = true
        mask.tag = 100
        
        let label = UILabel()
        label.text = "Uploading ..."
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: (fullscreen?.width)!/2-100 , y: (fullscreen?.height)!/2-120, width: 200.0, height: 200.0)
        label.font = UIFont.boldSystemFont(ofSize: 32)
        
        
        mask.addSubview(label)
        
        self.view.addSubview(mask)
        
        let uploadtask = storage.child(filename).putFile(from: videoURL as URL, metadata: nil){ metadata, error in
            if let error = error {
                print(error)
            }else{
                
                do {
                    let asset = AVURLAsset(url: self.videoURL , options: nil)
                    let imgGenerator = AVAssetImageGenerator(asset: asset)
                    imgGenerator.appliesPreferredTrackTransform = true
                    let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
                    let thumbnail = UIImage(cgImage: cgImage)
                    
                    
                    
                    // thumbnail here
                    
                } catch let error {
                    print("*** Error generating thumbnail: \(error.localizedDescription)")
                }
                               // !! check the error before proceeding
                
                
                let download = metadata!.downloadURLs
                print(download)
                let subViews = self.view.subviews
                for subview in subViews{
                    if subview.tag == 100 {
                        print("remove")
                        subview.removeFromSuperview()
                    }else{
                        print(subview.tag)
//                        let vc = TestingViewController(videoURL: (urlasd?[0])!)
//                        self.present(vc, animated: true, completion: nil)
                        
//                        self.dismiss(animated: true, completion: {
//                            self.dismiss(animated: true, completion: nil)
//                        })
                        
                    }
                }
               self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)


            }
        }
        
        let observer = uploadtask.observe(.progress) { snapshot in
            print(snapshot.progress) // NSProgress object
        }
    }

    
        
    func dismissMenu(){
        print("dismiss")
        UIView.animate(withDuration: 0.5, animations: {
            self.blackview?.alpha = 0
            self.mycollectionView?.frame.origin.y = (self.fullscreen?.height)!
        })
    }
        
    func addstickerView(){
        
        blackview  = UIView(frame: fullscreen!)
        blackview?.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackview?.isUserInteractionEnabled = true
        blackview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu)))
        
        
        self.view.addSubview(blackview!)
        
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.blackview?.alpha = 1
            self.view.bringSubview(toFront: self.mycollectionView!)
            self.mycollectionView?.frame.origin.y = (self.fullscreen?.height)! - (self.mycollectionView?.collectionViewLayout.collectionViewContentSize.height)!
        })
        
    }
    

    
    func scrollviewInit(){
        
        
        secc = UIScrollView()
        secc.frame = CGRect(x: 0, y: 0, width: (fullscreen?.width)!, height: (fullscreen?.height)!)
        secc.delegate = self as? UIScrollViewDelegate
        secc.isPagingEnabled = true
        secc.contentSize = CGSize(width: (fullscreen?.width)!*2, height: (fullscreen?.height)!)
        secc.showsHorizontalScrollIndicator = false
        secc.showsVerticalScrollIndicator = false
        
        let secondscreen = CGRect(x: self.view.bounds.width, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        let color = UIView(frame: fullscreen!)
        color.backgroundColor = UIColor.blue
        color.alpha = 0
        
        let color2 = UIView(frame: secondscreen)
        color2.layer.addSublayer(createGradient(colorTop: UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 0.2).cgColor
            , colorBotton: UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 0.8).cgColor))
        
        
        
        secc.addSubview(color)
        secc.addSubview(color2)
        
        
        self.view.addSubview(secc)
    }
    
    func createGradient(colorTop: CGColor, colorBotton: CGColor) -> CAGradientLayer{
        let gradient = CAGradientLayer()
        gradient.colors = [colorTop, colorBotton]
        gradient.locations = [0.0 ,1.0]
        gradient.frame = fullscreen!
        
        return gradient
        
    }
    
    
    //UICollectionView
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    // 必須實作的方法：每個 cell 要顯示的內容
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            // 依據前面註冊設置的識別名稱 "Cell" 取得目前使用的 cell
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "Cell", for: indexPath as IndexPath)
                    as! MyCollectionViewCell
            
            // 設置 cell 內容 (即自定義元件裡 增加的圖片與文字元件)
            cell.imageView.image =
                UIImage(named: "\(indexPath.item + 1).png")
            return cell
    }
    
    // 點選 cell 後執行的動作
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print("第 \(indexPath.item + 1) 張圖片")
        self.dismissMenu()
        
        let tempimage = UIImage(named: "\(indexPath.item + 1).png")
        let stickerView = self.buttonAction(imageName: tempimage!)
        
        self.view.addSubview(stickerView)
    }
    
    
    //stickerview
    
    /// gesturecontroller
    ///
    /// 1: 單點
    /// 2: 雙指單點
    /// 3: 拖曳
    /// 4: 縮放
    /// 5: 旋轉
    func buttonAction(imageName: UIImage) -> UIImageView{
        let gestureSelect = [3,4]
        let sticker = UIImageView(image: resizeImage(image: imageName, targetSize: CGSize(width: 200, height: 200)))
        gestureController(sender: sticker, types: gestureSelect)
        return sticker
    }
    
    
    
    func gestureController(sender: UIView, types: Array<Int>){
        
        //讓傳入的view可以被手勢影響
        sender.isUserInteractionEnabled = true
        
        for type in types {
            
            if(type == 1){
                //單指單擊
                let singleFinger =
                    UITapGestureRecognizer(target: self, action: #selector(VideoViewController.singleTap(recognizer:)))
                //singleFinger.require(toFail: doubleFingers)
                singleFinger.numberOfTapsRequired = 1
                singleFinger.numberOfTouchesRequired = 1
                sender.addGestureRecognizer(singleFinger)
            }else if(type == 2){
                //雙指單擊
                let doubleFingers =
                    UITapGestureRecognizer(target: self, action:#selector(VideoViewController.doubleTap(recognizer:)))
                doubleFingers.numberOfTapsRequired = 1
                doubleFingers.numberOfTouchesRequired = 2
                sender.addGestureRecognizer(doubleFingers)
            }else if(type == 3){
                //拖曳
                let pan = UIPanGestureRecognizer(target: self, action: #selector(VideoViewController.pan(recognizer:)))
                pan.minimumNumberOfTouches = 1
                pan.maximumNumberOfTouches = 1
                sender.addGestureRecognizer(pan)
            }else if(type == 4){
                //縮放
                let pinch = UIPinchGestureRecognizer(target: self, action: #selector(VideoViewController.pinch(recognizer:)))
                sender.addGestureRecognizer(pinch)
            }else if(type == 5){
                //旋轉
                let rotation = UIRotationGestureRecognizer(target: self, action: #selector(VideoViewController.rotation(recognizer:)))
                sender.addGestureRecognizer(rotation)
            }
        }
    }
    
    func singleTap(recognizer:UITapGestureRecognizer){
        print("單指連點一下")
        
        // 取得每指的位置
        self.findFingersPositon(recognizer: recognizer)
    }
    
    func doubleTap(recognizer:UITapGestureRecognizer){
        print("雙指點一下")
        
        // 取得每指的位置
        self.findFingersPositon(recognizer: recognizer)
    }
    
    
    func pan(recognizer: UIPanGestureRecognizer){
        //print("拖曳中..")
        
        let point = recognizer.location(in: self.view)
        let targetView = recognizer.view
        
        targetView?.center = point
    }
    
    func pinch(recognizer:UIPinchGestureRecognizer) {
        let targetView = recognizer.view
        if recognizer.state == .began {
            print("開始縮放")
        } else if recognizer.state == .changed {
            // 圖片原尺寸
            let frm = targetView?.frame
            
            // 縮放比例
            let scale = recognizer.scale
            
            // 目前圖片寬度
            let w = frm?.width
            
            // 目前圖片高度
            let h = frm?.height
            
            // 縮放比例的限制為 0.5 ~ 2 倍
            if w! * scale > 100 && w! * scale < 400 {
                print(scale)
                
                targetView?.transform = CGAffineTransform(scaleX: scale , y: scale)
            }
        } else if recognizer.state == .ended {
            print("結束縮放")
        }
        
    }
    
    func rotation(recognizer:UIRotationGestureRecognizer){
        let targetView = recognizer.view
        
        let radian = recognizer.rotation
        let angle = radian * (180 / CGFloat(M_PI))
        
        targetView?.transform = CGAffineTransform(rotationAngle: radian)
        
        print("\(angle)")
    }
    
    
    func findFingersPositon(recognizer:UITapGestureRecognizer) {
        // 取得每指的位置
        let number = recognizer.numberOfTouches
        for i in 0..<number {
            let point = recognizer.location(
                ofTouch: i, in: recognizer.view)
            print(
                "第 \(i + 1) 指的位置：\(NSStringFromCGPoint(point))")
        }
    }
    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    
    
    
}
