//
//  ViewController.swift
//  Swift5Bokete1
//
//  Created by 長井崚介 on 2021/02/03.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController {
    
    @IBOutlet weak var odaiImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var count = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        commentTextView.layer.cornerRadius = 20.0
    
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status){
                case .authorized: break
                case .denied: break
                case .notDetermined: break
                case .restricted: break
            }
        }
        
    }
    
    //検索キーワードの値を元に画像を引っ張ってくる
    //pixabay.com
    
    func getImages(keyword:String){
        
        //APIKEY 20137297-4d3ee138d66f4586429df98ef
        
        let url = "https://pixabay.com/api/?key=20137297-4d3ee138d66f4586429df98ef&q=\(keyword)"
        
        //Alamofireを使ってhttpリクエストを投げる
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON
        { (response) in
            
            switch response.result{
            
            case .success:
                let json:JSON = JSON(response.data as Any)
                let imageString = json["hits"][self.count]["webformatURL"].string
                self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                
                
            case .failure(let eeeor):
                
                print(eeeor)
                
            
            }
            
        }
        //値が返ってきて、それをJSONで解析を行う。
        
        //imageView.imageに貼り付ける
        
    }
    
    
}

