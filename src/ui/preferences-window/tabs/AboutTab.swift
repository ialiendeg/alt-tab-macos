import Cocoa

class AboutTab: NSObject {
    static func make() -> NSTabViewItem {
        return TabViewItem.make(NSLocalizedString("About", comment: ""), NSImage.infoName, makeView())
    }

    static func makeView() -> NSGridView {
        let appIcon = NSImageView(image: NSImage(named: "app-icon")!.resizedCopy(150, 150))
        appIcon.imageScaling = .scaleNone
        let appText = StackView([
            BoldLabel(App.name),
            NSTextField(wrappingLabelWithString: NSLocalizedString("Version", comment: "") + " " + App.version),
            NSTextField(wrappingLabelWithString: App.licence),
            HyperlinkLabel(NSLocalizedString("Source code repository", comment: ""), App.repository),
            HyperlinkLabel(NSLocalizedString("Latest releases", comment: ""), App.repository + "/releases"),
        ], .vertical)
        appText.spacing = GridView.interPadding / 2
        let rowToSeparate = 3
        appText.views[rowToSeparate].topAnchor.constraint(equalTo: appText.views[rowToSeparate - 1].bottomAnchor, constant: GridView.interPadding).isActive = true
        let appInfo = StackView([appIcon, appText])
        appInfo.spacing = GridView.interPadding
        appInfo.alignment = .centerY
        let sendFeedback = NSButton(title: NSLocalizedString("Send feedback…", comment: ""), target: self, action: #selector(feedbackCallback))
        let grid = GridView.make([
            [appInfo],
            [sendFeedback],
        ])
        let sendFeedbackCell = grid.cell(atColumnIndex: 0, rowIndex: 1)
        sendFeedbackCell.xPlacement = .center
        sendFeedbackCell.row!.topPadding = GridView.interPadding
        grid.fit()
        return grid
    }

    @objc
    static func feedbackCallback() {
        App.app.showFeedbackPanel()
    }
}
