//
//  AddRegistrationTableViewController.swift
//  HotelBooking
//
//  Created by user2 on 24/01/24.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController,SelectRoomTypeTableViewControllerDelegate {
    func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    var registrartion:Registration?{
        guard let roomType = roomType else {
            return nil
            
        }
        let lastName = lastNameTextField.text ?? ""
        let firstName = firstNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberofAdults = Int(numberOfAdultStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = WifiSwitch.isOn
        
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberofAdults, numberOfChildren: numberOfChildren, wifi: hasWifi, roomType: roomType)
        
    }
    
    var roomType:RoomType?
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    
    
    var isCheckInDatePickerVisible:Bool = false {
        didSet{
            checkInDatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }
    
    var isCheckOutDatePickerVisible:Bool = false {
        didSet{
            checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible
        }
    }
    

    @IBOutlet var firstNameTextField: UITextField!
    
    
    @IBOutlet var lastNameTextField: UITextField!
    
    
    @IBOutlet var emailTextField: UITextField!
    
    
    @IBOutlet var checkInDateLabel: UILabel!
    
    @IBOutlet var checkInDatePicker: UIDatePicker!
    
    
    @IBOutlet var checkOutDateLabel: UILabel!
    
    
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet var numberOfAdultStepper: UIStepper!
    
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet var numberOfAdultLabel: UILabel!
    
    @IBOutlet var numberOfChildrenLabel: UILabel!
    
    @IBOutlet var roomTypeLabel: UILabel!
    
    @IBOutlet var WifiSwitch: UISwitch!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case checkInDatePickerCellIndexPath where isCheckInDatePickerVisible == false : return 0
        case checkOutDatePickerCellIndexPath where isCheckOutDatePickerVisible == false: return 0
        default:
            return UITableView.automaticDimension
        }
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case checkOutDatePickerCellIndexPath:
            return 190
        case checkInDatePickerCellIndexPath:        return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == checkInDateLabelCellIndexPath && isCheckOutDatePickerVisible == false {
            isCheckInDatePickerVisible.toggle()
        }
        else if indexPath == checkOutDateLabelCellIndexPath && isCheckInDatePickerVisible == false {
            isCheckOutDatePickerVisible.toggle()
        }
        else if indexPath == checkInDateLabelCellIndexPath || indexPath == checkOutDateLabelCellIndexPath{
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible.toggle()
        }
        else {
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func updateRoomType(){
        if let roomType = roomType{
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "NOT SET"
        }
    }
    
    func updateDateViews(){
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDatePicker.date)
        checkInDateLabel.text = checkInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        checkOutDateLabel.text = checkOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    func updateNumberOfGuests(){
        numberOfAdultLabel.text = "\(Int(numberOfAdultStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
//    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
//        let lastName = lastNameTextField.text ?? ""
//        let firstName = firstNameTextField.text ?? ""
//        let email = emailTextField.text ?? ""
//        let checkInDate = checkInDatePicker.date
//        let checkOutDate = checkOutDatePicker.date
//        let numberofAdults = Int(numberOfAdultStepper.value)
//        let numberOfChildren = Int(numberOfChildrenStepper.value)
//        let hasWifi = WifiSwitch.isOn
//        let roomChoice = roomType?.name ?? "Not Set"
//        
//        print("Done Button Tapped")
//        print("First Name \(firstName), Last Name \(lastName), Email \(email)")
//        print("Check In Date:\(checkInDate) Check Out Date:\(checkOutDate)")
//        print("Adult: \(numberofAdults) , Children:\(numberOfChildren)")
//        print("Wifi : \(hasWifi)")
//        print("Room Choice: \(roomChoice)")
//        
//    }
//    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
    }
    
    
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
        let selectRoomTypeController = SelectRoomTypeTableViewController(coder:coder)
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType
        return selectRoomTypeController
    }
    

    @IBAction func CancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true,completion: nil)
    }
    
}
