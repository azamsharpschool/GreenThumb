//
//  AddNoteScreen.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/10/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddNoteScreen: View {
    
    let myGardenVegetable: MyGardenVegetable
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var noteTitle: String = ""
    @State private var noteBody: String = ""
    
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var uiImage: UIImage?
    @State private var imageData: Data?
    
    @State private var isCameraSelected: Bool = false
    
    private var isFormValid: Bool {
        !noteTitle.isEmptyOrWhiteSpace && !noteBody.isEmptyOrWhiteSpace
    }
    
    private func saveNote() {
        // save a new note
        let note = Note(title: noteTitle, body: noteBody)
        note.photo = imageData
        myGardenVegetable.notes?.append(note)
        try? context.save()
        dismiss() 
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $noteTitle)
            TextEditor(text: $noteBody)
                    .frame(minHeight: 200)
            
            
            HStack(spacing: 20) {
                
                Button {
                    // action
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        isCameraSelected = true
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.green.opacity(0.2))
                            .frame(width: 60, height: 60)
                        Image(systemName: "camera.fill")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                }
                
                PhotosPicker(selection: $selectedPhotoItem, matching: .images, photoLibrary: .shared()) {
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 60, height: 60)
                        Image(systemName: "photo.on.rectangle")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
            }.buttonStyle(.borderless)
            
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(maxWidth: 300, maxHeight: 300) // Set maximum size if needed
                // Add rounded corners using clipShape
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5) // Add shadow
                    .padding() // Optional: Add padding around the image
            }
            
        }
        .navigationTitle("\(myGardenVegetable.vegetable.name) Note")
        .task(id: selectedPhotoItem) {
            if let selectedPhotoItem {
                do {
                    if let data = try await selectedPhotoItem.loadTransferable(type: Data.self) {
                        uiImage = UIImage(data: data)
                        imageData = data
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .sheet(isPresented: $isCameraSelected, content: {
            ImagePicker(image: $uiImage, sourceType: .camera)
        })
        .onChange(of: uiImage, {
            imageData = uiImage?.pngData()
        })
        
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveNote()
                }.disabled(!isFormValid)
            }
        }
    }
}

#Preview(traits: .sampleData) {
    
    @Previewable @Query var myGardenVegetables: [MyGardenVegetable]
    
    NavigationStack {
        AddNoteScreen(myGardenVegetable: myGardenVegetables[0])
    }
}
