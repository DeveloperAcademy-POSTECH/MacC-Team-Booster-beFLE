//
//  MailView.swift
//  beFLE
//
//  Created by 정회승 on 11/16/23.
//

import MessageUI
import SwiftUI
import UIKit

public typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

public struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentation
    @Binding var data: ComposeMailData
    let callback: MailViewCallback
    
    public init(data: Binding<ComposeMailData>, callback: MailViewCallback) {
        _data = data
        self.callback = callback
    }
    
    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentation: PresentationMode
        @Binding var data: ComposeMailData
        let callback: MailViewCallback
        
        public init(presentation: Binding<PresentationMode>, data: Binding<ComposeMailData>, callback: MailViewCallback) {
            _presentation = presentation
            _data = data
            self.callback = callback
        }
        
        public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            error.map { callback?(.failure($0)) } ?? callback?(.success(result))
            $presentation.wrappedValue.dismiss()
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(presentation: presentation, data: $data, callback: callback)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject(data.subject)
        vc.setToRecipients(data.recipients)
        vc.setMessageBody(data.message, isHTML: false)
        data.attachments?.forEach { attachment in
            vc.addAttachmentData(attachment.data, mimeType: attachment.mimeType, fileName: attachment.fileName)
        }
        vc.accessibilityElementDidLoseFocus()
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {
    }
    
    public static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
}

public struct ComposeMailData {
    public let subject: String
    public let recipients: [String]?
    public let message: String
    public let attachments: [AttachmentData]?
    
    public init(subject: String, recipients: [String]?, message: String, attachments: [AttachmentData]?) {
        self.subject = subject
        self.recipients = recipients
        self.message = message
        self.attachments = attachments
    }
    
    public static let empty = ComposeMailData(subject: "", recipients: nil, message: "", attachments: nil)
}

public struct AttachmentData {
    public let data: Data
    public let mimeType: String
    public let fileName: String
    
    public init(data: Data, mimeType: String, fileName: String) {
        self.data = data
        self.mimeType = mimeType
        self.fileName = fileName
    }
}
