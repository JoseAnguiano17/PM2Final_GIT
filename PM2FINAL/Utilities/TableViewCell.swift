//
//  TableViewCell.swift
//  PM2FINAL
//
//  Created by user201443 on 6/14/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    public static var context: TableViewCell?

    @IBOutlet weak var nombreProducto: UILabel!
    @IBOutlet weak var imgProducto: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var descProducto: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code\\\\
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func test(_ sender: Any) {
    }
    
    func changeColor(_ option: Int){
        if option == 1 {
            self.contentView.backgroundColor = UIColor.white
        }else{
            self.contentView.backgroundColor = UIColor.darkGray
        }
        
    }
    
}
