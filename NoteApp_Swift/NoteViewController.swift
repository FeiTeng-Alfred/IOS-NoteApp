import UIKit

class NoteViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    // MARK: - Var
    var note : Note?
    
    // MARK: - IBOutlet
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!

    // MARK: - IBAction
    @IBAction func done(_ sender: AnyObject) {
        self.note?.text = self.textView.text
        self.note?.image = self.imageView.image
        //Swich back to previous controller. Need assign the return value otherwise 'compiler is giving that warning since you aren't capturing the value. The solution is to assign it to an underscore'
        //Check ref http://stackoverflow.com/questions/37843049/xcode-8-swift-3-expression-of-type-uiviewcontroller-is-unused-warning
    
        _ = navigationController?.popViewController(animated: true)
        
    }
    
//    @IBAction func test(_ sender: UIButton) {
//        let t = DataManager.getAllNotes()
//        guard let database = FMDatabase(path: Util.getPath("fei.sqlite")) else {
//            print("unable to create database")
//            return
//        }
//        
//        guard database.open() else {
//            print("Unable to open database")
//            return
//        }
//        
//        do {
////            try database.executeUpdate("create table test(x text, y text, z text)", values: nil)
//            try database.executeUpdate("insert into test (x, y, z) values (?, ?, ?)", values: ["a", "b", "c"])
//            try database.executeUpdate("insert into test (x, y, z) values (?, ?, ?)", values: ["e", "f", "g"])
//            
//            let rs = try database.executeQuery("select x, y, z from test", values: nil)
//            while rs.next() {
//                if let x = rs.string(forColumn: "x"), let y = rs.string(forColumn: "y"), let z = rs.string(forColumn: "z") {
//                    print("x = \(x); y = \(y); z = \(z)")
//                }
//            }
//        } catch {
//            print("failed: \(error.localizedDescription)")
//        }
//        
//        database.close()
//    }
    
    @IBAction func camera(_ sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .savedPhotosAlbum
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.text = self.note?.text
        self.imageView.image = self.note?.image
        
    }
    
    // MARK: - UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        self.imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    
    }
}
