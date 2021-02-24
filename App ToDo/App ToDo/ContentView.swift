//
//  ContentView.swift
//  App ToDo
//
//  Created by AndyZett on 16/02/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var taskStore = TaskStore()
    
    //Menghubungkan dengan var newToDo. Tampilan search bar di awal kosong
    @State var newToDo : String = ""
    
    //untuk membuat search bar, namun digunakan untuk menambah tugas baru
    
    var searchBar : some View {
        
        //Persamaan Horizontal
        HStack {
            
            //pembuatan text field, dimana isi text fieldnya kosong. Dihubungkan ke state var newToDo
            TextField("Ketik Tugas Anda", text: self.$newToDo)
                .font(.system(size: 20, weight: .semibold))
            
            //Button Tanbah untuk memasukkan data tugas baru
            Button(action: self.addNewToDo, label: {
                Text("Tambah")
                    .padding(6)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(3.0)
                
            })
            
            
                
        }
        
        
        
        
        
        
    }
    
    
    
    
    //untuk menambah list. Jika kita memasukkan string di search bar dan mengklik "tambah", akan menambah 1 tugas, lalu search bar menjadi kosong kembali
    func addNewToDo() {
        taskStore.tasks.append(Task(id: String(taskStore.tasks.count + 1), toDoItem: newToDo))
        self.newToDo = ""
        
    }
    
    var body: some View {
        
        
        
        //navigation
        NavigationView{
            
            
            //Persamaan Vertikal untuk list
            VStack(alignment: .leading) {
                
                Text("By: Umar")
                    .padding(20)
                    .foregroundColor(.green)
                    .font(.system(size: 20, weight: .bold))
                
                //searchbar, padding agar search bar tidak terlalu ke pinggir
                searchBar.padding()
                    .background(Color.yellow)
            
                //Membuat list yaitu daftar tugas
                List{
                    
                    //penjelasan dimana teks yg ada di dalam list adalah teks yang telah dimasukkan melalui searchh bar tadi
                    ForEach(self.taskStore.tasks) { task in
                        Text(task.toDoItem)
                        
                    //fitur dimana bisa menggeser tugas dihubungkan ke funcnya dibawah
                    }.onMove(perform: self.move)
                    
                    //fitur dimana bisa menghapus tugas dihubungkan ke funcnya dibawah
                    .onDelete(perform: self.delete)
                }
                
        
                //Judul besar "Daftar Tugas"
                .navigationTitle("Daftar Tugas")
                
                //kode untuk tulisan dan tombol "Edit" di pojok kanan atas
                .navigationBarItems(trailing: EditButton())
            
                VStack(alignment: .center){
                    Text("List Kegiatan-kegiatan Anda Agar Meningkatkan Tingkat Efisiensi")
                        .font(.system(.headline,design: .rounded))
                        .padding()
                        
                    
                }
                
            }
            
            
            
            
        }
        
        
        
    }
    
    //fitur dimana bisa menggeser tugas dihubungkan ke func nya dibawah
    func move(from source : IndexSet, to destination : Int) {
        taskStore.tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    //fitur dimana bisa menghapus tugas dihubungkan ke func nya dibawah
    func delete(at offsets : IndexSet) {
        taskStore.tasks.remove(atOffsets: offsets)
    }
    
}



//untuk preview canvas
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
