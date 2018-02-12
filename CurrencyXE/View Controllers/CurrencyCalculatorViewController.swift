//
//  CurrencyCalculatorViewController.swift
//  E-Work Hackathon
//
//  Created by moh on 12/18/17.
//  Copyright © 2017 aserdah. All rights reserved.
//

import UIKit
import Rswift
import Kingfisher
import  SwifterSwift
import AlamofireSwiftyJSON
import SVProgressHUD
class CurrencyCalculatorViewController: UIViewController {
    
    
    @IBOutlet weak var rightCode: UILabel!
    
    @IBOutlet weak var leftCode: UILabel!
    
    @IBOutlet weak var leftFlag: UIButton!
    
    @IBOutlet weak var rightFlag: UIButton!
    
    
    @IBOutlet weak var inputLable: UILabel!
    @IBOutlet weak var inputLableCurrency: UILabel!
    @IBOutlet weak var reslutLabel: UILabel!
    @IBOutlet weak var reslutLabelCurrency: UILabel!
    var inputCurrency = 0.0
    var outputCurrency = 0.0
    var selectedCountry = ""
     var letfCountryCode = "IT"
     var rightCountryCode = "US"
     var leftCurrencies = "EUR"
     var rightCurrencies = "USD"
    var rate = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        rightCode.text = rightCountryCode
        leftCode.text = letfCountryCode
        inputLable.text = " "
        let imgUrl = "https://raw.githubusercontent.com/hjnilsson/country-flags/master/png100px/\(rightCode.text!.lowercased()).png"
        
        let url = URL(string: imgUrl)
       
        rightFlag.kf.setImage(with: url, for: UIControlState.normal)
        
        let imgUrlf = "https://raw.githubusercontent.com/hjnilsson/country-flags/master/png100px/\(leftCode.text!.lowercased()).png"
    let urlf = URL(string: imgUrlf)
        leftFlag.kf.setImage(with: urlf, for: UIControlState.normal)
        
        inputLableCurrency.text = leftCurrencies
        reslutLabelCurrency.text = rightCurrencies
        print(rightCountryCode)
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if(selectedCountry == "l"){
            leftCode.text = CountryTableViewController.selectedCode
             leftCurrencies = CountryTableViewController.selectedCurrencies
            let imgUrlf = "https://raw.githubusercontent.com/hjnilsson/country-flags/master/png100px/\(leftCode.text!.lowercased()).png"
            let urlf = URL(string: imgUrlf)
            leftFlag.kf.setImage(with: urlf, for: UIControlState.normal)
            inputLableCurrency.text = leftCurrencies

        }
        else{
              rightCode.text = CountryTableViewController.selectedCode
            rightCurrencies = CountryTableViewController.selectedCurrencies
            let imgUrl = "https://raw.githubusercontent.com/hjnilsson/country-flags/master/png100px/\(rightCode.text!.lowercased()).png"
            
            let url = URL(string: imgUrl)
            
            rightFlag.kf.setImage(with: url, for: UIControlState.normal)
            reslutLabelCurrency.text = rightCurrencies
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func lCountryBtnTapped(_ sender: Any) {
        selectedCountry = "l"
     let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryTableViewController")
        self.present(vc!, animated: true, completion: nil)
        
    }
    @IBAction func rCountryBtnTapped(_ sender: Any) {
    selectedCountry = "r"
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryTableViewController")
        self.present(vc!, animated: true, completion: nil)
      
       
        
    }
    @IBAction func calcBtnTapped(_ sender: Any) {
        
        print (inputLable.text!)
        inputCurrency = (inputLable.text?.double())!
        SVProgressHUD.show()
        RequestWrapper.init().getConvert(from: leftCurrencies, to: rightCurrencies) { (model) in
            SVProgressHUD.dismiss()
            self.rate = (model?.rate!)!
            print((model?.rate!)!)
            self.outputCurrency = self.inputCurrency*self.rate
            self.reslutLabel.text = self.outputCurrency.string
        }
        
        
    }
    
    @IBAction func numTapped(_ sender: UIButton) {
        
        if(sender.isSelected||sender.isHighlighted){
             sender.borderWidth = 4
            
        }
    
            sender.borderWidth = 1
     
        
       
        
        switch (sender.titleLabel?.text!){
            
        case "1"?:
            inputLable.text = inputLable.text! + "1"
        case "2"?:
            inputLable.text = inputLable.text! + "2"
        case "3"?:
            inputLable.text = inputLable.text! + "3"
        case "4"?:
            inputLable.text = inputLable.text! + "4"
        case "5"?:
            inputLable.text = inputLable.text! + "5"
        case "6"?:
            inputLable.text = inputLable.text! + "6"
        case "7"?:
            inputLable.text = inputLable.text! + "7"
        case "8"?:
            inputLable.text = inputLable.text! + "8"
        case "9"?:
            inputLable.text = inputLable.text! + "9"
        case ","?:
            inputLable.text = inputLable.text! + "."
        case "0"?:
            inputLable.text = inputLable.text! + "0"
        
            
        default: break
            
         
            
            
            
        }
        switch (sender.titleLabel?.text!){
        case "CE"?:
            inputLable.text = " "
        default:do {
            self.inputCurrency = (inputLable.text?.double())!
            SVProgressHUD.show()
            RequestWrapper.init().getConvert(from: leftCurrencies, to: self.rightCurrencies) { (model) in
                SVProgressHUD.dismiss()
                self.rate = (model?.rate!)!
                print((model?.rate!)!)
                self.outputCurrency = self.inputCurrency*self.rate
                self.reslutLabel.text = self.outputCurrency.string
            }
            
            }
            
        }
        
        
        
        
    }
    
    
    
}
