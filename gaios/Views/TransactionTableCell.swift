import Foundation
import UIKit

class TransactionTableCell: UITableViewCell {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var replaceable: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        replaceable.layer.masksToBounds = true
        replaceable.layer.cornerRadius = 4
        replaceable.layer.borderWidth = 1
        replaceable.layer.borderColor = UIColor.customTitaniumLight().cgColor

    }

    func setup(with transaction: Transaction) {
        replaceable.isHidden = !transaction.canRBF
        amount.text = transaction.amount()
        selectionStyle = .none
        date.text = transaction.date()
        replaceable.text = "  " + NSLocalizedString("id_replaceable", comment: "").uppercased() + "  "
        separatorInset = UIEdgeInsetsMake(0, 18, 0, 18)
    }

    func checkBlockHeight(transaction: Transaction, blockHeight: UInt32) {
        if transaction.blockHeight == 0 {
            status.text = NSLocalizedString("id_unconfirmed", comment: "")
            status.textColor = UIColor.errorRed()
        } else if (blockHeight < transaction.blockHeight + 5) {
            let confirmCount = blockHeight - transaction.blockHeight + 1
            status.textColor = UIColor.customTitaniumLight()
            status.text = String(format: NSLocalizedString("id_d6_confirmations", comment: ""), confirmCount)
        } else {
            status.text = NSLocalizedString("id_completed", comment: "")
            status.textColor = UIColor.customTitaniumLight()
        }
    }

    func checkTransactionType(transaction: Transaction) {
        if transaction.type == "redeposit" {
            address.text = NSLocalizedString("id_redeposited", comment: String())
            amount.textColor = UIColor.white
        } else if transaction.type == "incoming" {
            address.text = NSLocalizedString("id_received", comment: String())
            amount.textColor = UIColor.customMatrixGreen()
        } else {
            address.text = transaction.address()
            amount.textColor = UIColor.white
        }
    }
}
