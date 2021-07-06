//
//  ShareViewController.swift
//  ShareTest
//
//  Created by ray on 2021/7/6.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet var custom: UIView!
    
    override func loadView() {
        custom.backgroundColor = .red
        self.view = custom
    }
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.init(suiteName: "group.rrr.rrr")
        let inputItems =  self.extensionContext?.inputItems
        
        let obj = inputItems?.first as? NSExtensionItem ;
        let provider = obj?.attachments?.first
        
        provider?.loadPreviewImage(options: [:], completionHandler: { item, error in
            if let m = item as? UIImage {
                let data = m.pngData();
                self.imgView.image = m
                userDefaults?.setValue(data, forKey: "shareImage")
                userDefaults?.synchronize()
            }
            
            
        })
        
        if let  dataType = provider?.registeredTypeIdentifiers.first {
            print("dataType  \(dataType)")
            provider?.loadItem(forTypeIdentifier: dataType, options: [:], completionHandler: { item, error in
                
                userDefaults?.setValue("\(item)", forKey: "shareURL")
                userDefaults?.synchronize()
            })
        }
        
        
        print("self.contentText \(self.contentText)  inputItems \(inputItems)")
    }
    
    
    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        let userDefaults = UserDefaults.init(suiteName: "group.rrr.rrr")
        userDefaults?.setValue(true, forKey: "isShare")
        userDefaults?.synchronize()
        
        let inputItems =  self.extensionContext?.inputItems
        
        let obj = inputItems?.first as? NSExtensionItem ;
        let provider = obj?.attachments?.first
        
        provider?.loadPreviewImage(options: [:], completionHandler: { item, error in
            if let m = item as? UIImage {
                let data = m.pngData();
                
                userDefaults?.setValue(data, forKey: "shareImage")
                userDefaults?.synchronize()
            }
            
            
        })
        
        if let  dataType = provider?.registeredTypeIdentifiers.first {
            print("dataType  \(dataType)")
            provider?.loadItem(forTypeIdentifier: dataType, options: [:], completionHandler: { item, error in
                
                userDefaults?.setValue(item, forKey: "shareURL")
                userDefaults?.synchronize()
            })
        }
        
        
        print("self.contentText \(self.contentText)  inputItems \(inputItems)")
        
//        NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.steven.app"];
//        [userDefaults setBool:YES forKey:@"isShare"];
//        [userDefaults synchronize];
        
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    @IBAction func fabuClick(_ sender: Any) {
        let inputItems =  self.extensionContext?.inputItems
        
        let obj = inputItems?.first as? NSExtensionItem ;
        let provider = obj?.attachments?.first
        let  dataType = provider?.registeredTypeIdentifiers.first
        print("self.contentText \(self.contentText)  inputItems \(inputItems)  dataType \(dataType)")
        
    }
    
    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
