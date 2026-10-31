import AppKit
import ImageIO
import UniformTypeIdentifiers

let output = URL(fileURLWithPath: "assets/demo.gif")
try FileManager.default.createDirectory(
    at: output.deletingLastPathComponent(),
    withIntermediateDirectories: true
)

let width = 1000
let height = 520
let frames: [(String, [String], TimeInterval)] = [
    (
        "ROUGH PROMPT",
        [
            "> /effective-prompt Write a product launch email.",
            "",
            "The goal, audience, tone, facts, and output format are unclear."
        ],
        1.8
    ),
    (
        "ANALYZING",
        [
            "✓ Intent and audience",
            "✓ Context and constraints",
            "✓ Deliverable and success criteria",
            "✓ Ambiguities and missing inputs"
        ],
        1.5
    ),
    (
        "IMPROVED PROMPT",
        [
            "Write a concise product-launch email for existing customers.",
            "Use a confident, friendly tone and include a subject line,",
            "a short explanation of the customer benefit, and one clear CTA.",
            "Use only the product facts I provide; flag anything still missing."
        ],
        3.2
    ),
    (
        "INSTALL ONCE. USE IN EVERY AGENT.",
        [
            "$ npx effective-prompt@latest",
            "",
            "Claude Code  •  Codex  •  Google Antigravity"
        ],
        2.2
    )
]

func draw(_ text: String, x: CGFloat, y: CGFloat, size: CGFloat, color: NSColor, bold: Bool = false) {
    let fontName = bold ? "Menlo-Bold" : "Menlo"
    let attributes: [NSAttributedString.Key: Any] = [
        .font: NSFont(name: fontName, size: size) ?? NSFont.monospacedSystemFont(ofSize: size, weight: bold ? .bold : .regular),
        .foregroundColor: color
    ]
    text.draw(at: NSPoint(x: x, y: y), withAttributes: attributes)
}

func makeFrame(title: String, lines: [String]) -> CGImage {
    let image = NSImage(size: NSSize(width: width, height: height))
    image.lockFocus()

    NSColor(calibratedRed: 0.04, green: 0.05, blue: 0.08, alpha: 1).setFill()
    NSBezierPath(rect: NSRect(x: 0, y: 0, width: width, height: height)).fill()

    NSColor(calibratedRed: 0.09, green: 0.11, blue: 0.16, alpha: 1).setFill()
    NSBezierPath(roundedRect: NSRect(x: 30, y: 30, width: 940, height: 460), xRadius: 18, yRadius: 18).fill()

    for (index, color) in [NSColor.systemRed, .systemYellow, .systemGreen].enumerated() {
        color.setFill()
        NSBezierPath(ovalIn: NSRect(x: 58 + CGFloat(index * 28), y: 450, width: 14, height: 14)).fill()
    }

    draw("effective-prompt", x: 390, y: 445, size: 17, color: NSColor(calibratedWhite: 0.65, alpha: 1))
    draw(title, x: 70, y: 370, size: 24, color: NSColor(calibratedRed: 0.45, green: 0.84, blue: 1, alpha: 1), bold: true)

    for (index, line) in lines.enumerated() {
        let isCommand = line.hasPrefix(">") || line.hasPrefix("$")
        draw(
            line,
            x: 70,
            y: 310 - CGFloat(index * 52),
            size: 20,
            color: isCommand ? NSColor(calibratedRed: 0.52, green: 0.95, blue: 0.68, alpha: 1) : NSColor(calibratedWhite: 0.9, alpha: 1),
            bold: isCommand
        )
    }

    image.unlockFocus()
    guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
        fatalError("Could not render demo frame")
    }
    return cgImage
}

guard let destination = CGImageDestinationCreateWithURL(
    output as CFURL,
    UTType.gif.identifier as CFString,
    frames.count,
    nil
) else {
    fatalError("Could not create GIF destination")
}

CGImageDestinationSetProperties(destination, [
    kCGImagePropertyGIFDictionary: [kCGImagePropertyGIFLoopCount: 0]
] as CFDictionary)

for frame in frames {
    CGImageDestinationAddImage(
        destination,
        makeFrame(title: frame.0, lines: frame.1),
        [kCGImagePropertyGIFDictionary: [kCGImagePropertyGIFDelayTime: frame.2]] as CFDictionary
    )
}

guard CGImageDestinationFinalize(destination) else {
    fatalError("Could not write assets/demo.gif")
}

print("Generated \(output.path)")
