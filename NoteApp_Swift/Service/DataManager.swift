//Note: 2016-12-04 10:07:19.802 NoteApp_Swift[14403:455957] Error calling sqlite3_step (21: out of memory) rs
//The above error is caused by trying to iterate FMResultSet after close database....sucks..


class DataManager: NSObject {
    
    class func getAllNotes() -> Array<Note> {
        var notes : [Note] = []
        
//        let allNotes = self.runQuery(query: "select title, text from notes");
        
        guard let database = FMDatabase(path: Util.getPath("fei.sqlite")) else {
            print("unable to create database")
            return notes
        }

        guard database.open() else {
            print("Unable to open database")
            return notes
        }


        do {
            let result = try database.executeQuery("select title, text from notes", values:nil)
            while (result.next()) {
                let note = Note()
                //todo why have to add question mark for allNotes
                note.text = result.string(forColumn: "text")
                note.title = result.string(forColumn: "title")
                notes.append(note);
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
        
        return notes
    }
    
    class func addNote(note: Note)-> Bool {
        guard let database = FMDatabase(path: Util.getPath("fei.sqlite")) else {
            print("unable to create database")
            return false
        }
        guard database.open() else {
            print("Unable to open database")
            return false
        }
        do {
            try database.executeUpdate("insert into notes (title, text) values (\(note.title), \(note.text))", withArgumentsIn: nil)
        } catch {
            print("failed: \(error.localizedDescription)")
            return false
        }
        database.close()
        return true
    }
    
//    class func runQuery(query: String) -> FMResultSet? {
//        var result : FMResultSet?  = nil
//
//        guard let database = FMDatabase(path: Util.getPath("fei.sqlite")) else {
//            print("unable to create database")
//            return result
//        }
//        
//        guard database.open() else {
//            print("Unable to open database")
//            return result
//        }
//                
//        
//        do {
//            result = try database.executeQuery("select title, text from notes", values:nil)
//        } catch {
//            print("failed: \(error.localizedDescription)")
//        }
//        
//        database.close()
//        
//        return result
//
//    }

}
