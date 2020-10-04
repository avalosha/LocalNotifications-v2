//
//  ViewController.swift
//  Project21
//
//  Created by Álvaro Ávalos Hernández on 03/10/20.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }
    
    //Solicitar permiso al usuario
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        //Configuración de la notificación
        //mensaje, insignia y sonido
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }

    }

    //Configuración de la información a mostrar en la notificación
    //Contenido, activador y solicitud
    @objc func scheduleLocal() {
        let center = UNUserNotificationCenter.current()
        //Cancela las notificaciones pendientes
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Title goes here"
        content.body = "Main text goes here"
        content.categoryIdentifier = "customIdentifier" //Acciones personalizadas
        content.userInfo = ["customData": "fizzbuzz"]   //Adjunta datos personalizados
        content.sound = UNNotificationSound.default
        
        //Trigger de calendario
//        var dateComponents = DateComponents()
//        dateComponents.hour = 10
//        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //Trigger de intervalo(más rapido de ejecutar)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //Para evitar multiples notificaciones mejor se actualiza el mismo usando un identificador unico
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }

}

