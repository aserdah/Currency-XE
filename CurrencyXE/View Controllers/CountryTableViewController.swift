//
//  TableViewController.swift
//  Network
//
//  Created by Ahmed on 12/8/17.
//  Copyright © 2017 aserdah. All rights reserved.
//

import UIKit
import Alamofire
import MagicalRecord
import CoreData
import Kingfisher
import SVProgressHUD

class CountryTableViewController: UIViewController, UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    static var selectedCode = "US"
    static var selectedCurrencies = "USD"
    var objects = Array<Dictionary<String, Any>>()
     var countryObjects = [Country].init()
     var displayObjects = [Country].init()
    override func viewDidLoad() {
        super.viewDidLoad()
        let baseUrl = "https://restcountries.eu/rest/v2"
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "af612e36-e103-d646-9b49-d24514c26a02"
        ]
        SVProgressHUD.show()
     Alamofire.request(baseUrl, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON{ response in
         // print("aaaaaaaaa")
            if let json = response.result.value {
                self.objects = json as! Array<Dictionary<String, Any>>
               
               
             
               
            }
        for obj in self.objects {
            
            let counrty = Country.mr_findFirstOrCreate(byAttribute: "name", withValue: obj["name"] as! String)
            let currencies =  obj["currencies"] as! Array<Dictionary<String, Any>>
           
            counrty.code = currencies.first!["code"] as? String
            counrty.flag = obj["alpha2Code"]  as? String
            self.displayObjects.append(counrty)
            
        }
        SVProgressHUD.dismiss()

        try! NSManagedObjectContext.mr_default().save()
        self.countryObjects = Country.mr_findAll() as! [Country]
        print(self.countryObjects.count)
       
        self.displayObjects =   self.countryObjects
         self.tableView.reloadData()
        
        }
        print(objects.count)
        
       
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        return displayObjects.count
      
    }

  
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        // Configure the cell...
       
        let obj = displayObjects[indexPath.row]
        let code = obj.flag!
        cell.name.text = obj.name
       
        cell.code.text = obj.code
        let imgUrl = "https://raw.githubusercontent.com/hjnilsson/country-flags/master/png100px/\(code.lowercased()).png"
   
        let url = URL(string: imgUrl)
        cell.flag.kf.setImage(with: url)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = displayObjects[indexPath.row]
        
        
        // get the
        CountryTableViewController.selectedCurrencies = obj.code!
        CountryTableViewController.selectedCode = obj.flag!
        
        print("a")
 
        //

    }
 
  

    

    @IBAction func searchBtnTapped(_ sender: Any) {
        if(searchTextField.text != ""){
            displayObjects = countryObjects.filter({( country : Country) -> Bool in
                return (country.name?.lowercased().contains(searchTextField.text!.lowercased()))!
            })
        }
        else{
            displayObjects = countryObjects
        }
        
        tableView.reloadData()
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(searchTextField.text != ""){
            displayObjects = countryObjects.filter({( country : Country) -> Bool in
                return (country.name?.lowercased().contains(searchTextField.text!.lowercased()))!
            })
        }
        else{
            displayObjects = countryObjects
        }
        
        tableView.reloadData()
        return true
    }
}
