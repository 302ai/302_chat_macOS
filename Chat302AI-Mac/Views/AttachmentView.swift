//
//  AttachmentView.swift
//  Chat302AI-Mac
//

import AppKit
import SwiftUI
import UniformTypeIdentifiers

enum AttachmentContent {
    case text(String)
}


struct LLMAttachment: Identifiable, Equatable {
    var id = UUID()
    var filename: String
    var fileExtension: String
    var url: URL?
    var fileIcon: NSImage?
    var fileType: UTType
    var content: AttachmentContent
    
    static func == (lhs: LLMAttachment, rhs: LLMAttachment) -> Bool {
        lhs.filename == rhs.filename &&
        lhs.fileExtension == rhs.fileExtension &&
        lhs.url == rhs.url &&
        lhs.fileType == rhs.fileType
    }
}

struct AttachmentView: View {
    
    @Binding var allAttachments: [LLMAttachment]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 5) {
                ForEach(Array(allAttachments.enumerated()), id: \.element.id) { index, attachment in
                    AttachmentPill(allAttachments: $allAttachments, attachment: attachment)
                }
            }
        }
        .scrollIndicators(.never)
        .background(.white.opacity(0.01))
    }
}

struct AttachmentPill: View {
    
    @Binding var allAttachments: [LLMAttachment]
    var attachment: LLMAttachment
    @State private var showRemoveButton: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            if let icon = attachment.fileIcon {
                Image(nsImage: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
            } else {
                Image(nsImage: NSWorkspace.shared.icon(for: attachment.fileType))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
            }
            Text("\(attachment.filename)")
                .font(ThemingEngine.shared.currentTheme.markdownFont?.footnote ?? .footnote)
                .lineLimit(1)
            Spacer(minLength: 5)
            
            Button("Remove", systemImage: "xmark.circle.fill", action: {
                allAttachments.removeAll { $0.id == attachment.id }
            })
            .labelsHidden()
            .frame(width: 15, height: 15)
            .opacity(showRemoveButton ? 1:0)
            .buttonStyle(.borderless)
            .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 5)
        .padding(.leading, 10)
        .frame(maxWidth: 160)
        .background(.regularMaterial)
        .clipShape(.capsule)
        .fixedSize()
        .onHover { state in
            showRemoveButton = state
        }
    }
}
