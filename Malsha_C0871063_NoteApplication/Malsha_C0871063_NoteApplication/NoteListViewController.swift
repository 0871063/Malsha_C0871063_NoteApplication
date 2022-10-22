//
//  ViewController.swift
//  Malsha_C0871063_NoteApplication
//
//  Created by Malsha Lambton on 2022-10-22.
//

import UIKit

class NoteListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var noteTableView: UITableView!
    
    var noteList : [Note] = []
    var selectedNote : Note?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }

    @IBAction func editNoteList(_ sender: UIBarButtonItem) {
        if noteTableView.isEditing {
            noteTableView.isEditing = false
            editButton.title = "Edit"
        }else{
            noteTableView.isEditing = true
            editButton.title = "Done"
        }
    }
    
    func updateNoteList(with note : Note){
        if let row = self.noteList.firstIndex(where: {$0.noteId == note.noteId}) {
            self.noteList[row] = note
  
        } else {
            if note.note != "" {
                noteList.append(note)
            }
        }
        noteTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? AddNoteViewController {
            nextViewController.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell",
                                                        for: indexPath)
        cell.textLabel?.text = self.noteList[indexPath.row].note
               return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addNoteView = storyboard.instantiateViewController(withIdentifier: "AddNoteViewController") as! AddNoteViewController
        addNoteView.selectedNote = self.noteList[indexPath.row]
        addNoteView.delegate = self
        navigationController?.pushViewController(addNoteView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        if noteTableView.isEditing
        {
            return true
        }else{
            return false
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            noteList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.noteList[sourceIndexPath.row]
        noteList.remove(at: sourceIndexPath.row)
        noteList.insert(movedObject, at: destinationIndexPath.row)
    }
    
}

