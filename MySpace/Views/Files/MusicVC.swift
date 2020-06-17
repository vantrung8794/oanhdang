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
    
    var player: AVAudioPlayer?
    
    @IBOutlet weak var tableView: UITableView!
    let vm = MusicVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MusicCell.self)
        vm.initMusic()
        vm.listMusic.subscribe(onNext: {lst in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let play = player, play.isPlaying {
            player?.stop()
            var temp = vm.listMusic.value
            for (i, element) in temp.enumerated() {
                if element.isPlay {
                    temp[i].isPlay = false
                }
            }
            vm.listMusic.accept(temp)
        }
    }
}

extension MusicVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.listMusic.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configCell(vm.listMusic.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playSound(indexPath.row)
    }
    
    func playSound(_ index: Int) {
        var temp = vm.listMusic.value
        for (i, element) in temp.enumerated() {
            if element.isPlay {
                temp[i].isPlay = false
            }
        }
        guard let url = Bundle.main.url(forResource: vm.listMusic.value[index].url ?? "", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
            
            temp[index].isPlay = true
            vm.listMusic.accept(temp)
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
