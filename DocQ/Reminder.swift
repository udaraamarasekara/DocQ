//
//  Reminder.swift
//  DocQ
//
//  Created by udara prabath on 2025-04-05.
//
import EventKit


    // Function to show an alert if permission is denied
   

    // Request permission to access reminders
    public func requestReminderPermission() {
        let eventStore = EKEventStore()

        // Request access to reminders
        eventStore.requestAccess(to: .reminder) { (granted, error) in
            DispatchQueue.main.async {
                if granted {
                    print("Permission granted to access reminders.")
                } else {
                    print("Permission denied or error occurred: \(error?.localizedDescription ?? "No error description.")")
                }
            }
        }
    }

    // Create the reminder
   public func createReminder(date: String) {
        let eventStore = EKEventStore()
        // Define the target date (April 6, 2025 at 2:00 PM)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone.current

        guard let targetDate = formatter.date(from: date) else {
            print("Failed to parse date")
            return
        }

        // Create reminder
        let reminder = EKReminder(eventStore: eventStore)
        reminder.title = "Doctor Appointment Reminder"
        reminder.calendar = eventStore.defaultCalendarForNewReminders()

        // Add alarm (trigger at exact time)
        let alarm = EKAlarm(absoluteDate: targetDate)
        reminder.addAlarm(alarm)

        // Save reminder
        do {
            try eventStore.save(reminder, commit: true)
            print("Reminder saved for \(formatter.string(from: targetDate))")
        } catch {
            print("Error saving reminder: \(error.localizedDescription)")
        }
    }






