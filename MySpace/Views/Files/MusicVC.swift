//
//  MusicVC.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/16/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

class MusicVC: BaseVC {
    
    var player = AVPlayer()
    
    @IBOutlet weak var tableView: UITableView!
    let vm = MusicVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MusicCell.self)
        StaticVM.listMusics.subscribe(onNext: {lst in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        vm.isDeleteSuccess.filter{$0}.subscribe(onNext: { _ in
            StaticVM.getListBucket(inVC: self)
        }).disposed(by: disposeBag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.pause()
        let temp = StaticVM.listMusics.value
        for (i, element) in temp.enumerated() {
            if element.isPlay {
                temp[i].isPlay = false
            }
        }
        StaticVM.listMusics.accept(temp)
    }
}

extension MusicVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StaticVM.listMusics.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configCell(StaticVM.listMusics.value[indexPath.row])
        cell.didDelete = {
            AlertBuilder()
                .setTitle("Đăng xuất")
                .setSubText("Bạn có chắc chắn muốn xoá \(StaticVM.listMusics.value[indexPath.row].file_name ?? "")?")
                .setAction1(withTitle: "Đồng ý") {
                    self.vm.deleteFile(inVC: self, fileName: StaticVM.listMusics.value[indexPath.row].file_name ?? "")
            }
            .setAction2(withTitle: "Huỷ") {
                
            }.show()
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if StaticVM.listMusics.value[indexPath.row].isPlay {
            pause()
            let temp = StaticVM.listMusics.value
            temp[indexPath.row].isPlay = false
            StaticVM.listMusics.accept(temp)
            return
        }
        pause()
        let temp = StaticVM.listMusics.value
        for (i, element) in temp.enumerated() {
            if element.isPlay {
                temp[i].isPlay = false
            }
        }
        temp[indexPath.row].isPlay = true
        StaticVM.listMusics.accept(temp)
        initPlayer(url: StaticVM.listMusics.value[indexPath.row].file_url ?? "")
        play()
    }

   func initPlayer(url : String) {
       guard let url = URL.init(string: url) else { return }
       let playerItem = AVPlayerItem.init(url: url)
       player = AVPlayer.init(playerItem: playerItem)
       playAudioBackground()
   }

   func playAudioBackground() {
       do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers, .allowAirPlay])
           print("Playback OK")
           try AVAudioSession.sharedInstance().setActive(true)
           print("Session is Active")
       } catch {
           print(error)
       }
   }

   func pause(){
       player.pause()
   }

   func play() {
       player.play()
   }
}
