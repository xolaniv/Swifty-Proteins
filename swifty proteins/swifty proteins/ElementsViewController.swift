//
//  ElementsViewController.swift
//  swifty proteins
//
//  Created by Xolani VILAKAZI on 2019/11/29.
//  Copyright © 2019 Xolani VILAKAZI. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    var fileName = "lingands"
    var fileType = "txt"
    
    // variable to contain data retireved from the list
    var list = [String]()
    // varaible to validate if items are being searched
    var searching = false
    // shows data from the list after search
    var filteredData = [String]()
    var myIndex = 0
    
    
    /*Function to read the text file and split it into lines
     *assisgns data from text file to the array of list
     */
    private func showLigands() {
        let fileUrl = Bundle.main.url(forResource: fileName, withExtension: fileType)
        
        do {
            let str = try String(contentsOf: fileUrl!, encoding: String.Encoding.utf8)
            list = str.components(separatedBy: "\n")
        }
        catch let error as NSError {
            print("Failed reading from URL: " + "Error -> " + error.localizedDescription)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredData.count
        }
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as! ElementTableViewCell
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "elementCell")
        //let text: String
        
        if searching {
            cell.elementLabel.text = self.filteredData[indexPath.row]
        }
        else {
            //text = list[indexPath.row]
            cell.elementLabel.text = self.list[indexPath.row]

        }
        //cell.elementLabel.text = self.list[indexPath.row]
        //cell.textLabel?.text = text
        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myIndexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: myIndexPath!) as! ElementTableViewCell
        myIndex = list.firstIndex(of: currentCell.elementLabel.text!)!
        performSegue(withIdentifier: "showProtein", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController : ProtienViewController = segue.destination as! ProtienViewController
        destViewController.Protein = list[myIndex]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder()
        searchBar.returnKeyType =  UIReturnKeyType.done
        self.showLigands()
        //tableView.delegate = self
        //tableView.dataSource = self
        self.tableView.reloadData()
        
        
        searchBar.returnKeyType = UIReturnKeyType.done

        // Do any additional setup after loading the view.
    }
    
    
     public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text == nil || searchBar.text == "" {
                searching = false
                tableView.reloadData()
            }
            else {
                searching = true
                //filteredData = list.filter({ $0.lowercased().range(of:searchBar.text!.lowercased()!)})
                filteredData = list.filter({$0.contains((searchBar.text?.uppercased())!)})
                tableView.reloadData()
            }
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
