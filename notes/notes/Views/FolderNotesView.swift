//
//  FolderNotesView.swift
//  notes
//
//  Created by Qicheng Geng on 4/18/23.
//

import SwiftUI

struct FolderNotesView: View {
    var folder: Folder
    @State private var showingNewNoteView = false
    @ObservedObject var myNotes: MyNotes

    var body: some View {
        List {
            ForEach(folder.notes) { note in
                Text(note.text)
            }
            .onDelete(perform: { indexSet in
                // Remove notes at the specified indices
                myNotes.removeNote(index: indexSet)
            })
        }
        .navigationTitle(folder.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SingleNoteView(myNotes: myNotes), isActive: $showingNewNoteView) {
                    Button(action: {
                        showingNewNoteView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}



struct FolderNotesView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleFolder = Folder(name: "Academy", notes: [
            Note(text: "Math"),
            Note(text: "Physics"),
            Note(text: "Chemistry"),
        ])
        
        let testNotes = MyNotes()
        testNotes.folders = [sampleFolder]
        
        return FolderNotesView(folder: sampleFolder, myNotes: testNotes)
    }
}

