import UIKit

class NoteListViewController: UIViewController,UITableViewDataSource {
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.navigationItem.leftBarButtonItem = self.editButtonItem // editButton
        
    }
    
    // MARK: - Var
    //Array of notes
    var notes : [Note] = []
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBAction
    @IBAction func addNote(_ sender: AnyObject) {
        let note = Note()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        note.title = formatter.string(from: date)
        note.text = "New Note"
        
        // insertRows at the Top
        self.notes.insert(note, at: 0)
        self.tableView.insertRows(at: [NSIndexPath(row:0, section: 0) as IndexPath], with: .automatic)
    }
    
    // MARK: - initCoder
    required init?(coder aDecoder: NSCoder) {
        Util.copyFile("fei.sqlite");
        self.notes = DataManager.getAllNotes()
        super.init(coder: aDecoder)
    }
    
    // MARK: - reorder & Delete
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: true)
    }
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        let note = self.notes[indexPath.row]
        cell.textLabel?.text = note.title
//        cell.imageView?.image = note.image
        
        // for setEditing
        cell.showsReorderControl = true
        
        return cell
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let note = self.notes[sourceIndexPath.row]
        // remove -> insert
        self.notes.remove(at: sourceIndexPath.row)
        self.notes.insert(note, at: destinationIndexPath.row)
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.notes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNoteViewController"{
            
            let noteViewController = segue.destination as! NoteViewController
            if  let indexPath = self.tableView.indexPathForSelectedRow {
                let note = self.notes[indexPath.row]
                noteViewController.note = note
                
            }
        }
    }
    
    
}
