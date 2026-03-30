import UIKit
import SolutionSDK
import AVFoundation
import SnapKit

public class ViewController: UIViewController {

    private let urlTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Paste or scan a solution URL"
        tf.borderStyle = .roundedRect
        tf.font = .systemFont(ofSize: 14)
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        return tf
    }()

    private let scanButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Scan QR Code", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.backgroundColor = .systemOrange
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        return btn
    }()

    private let startButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Start Solution", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        return btn
    }()

    private let resultTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.font = .systemFont(ofSize: 13)
        tv.textColor = .darkGray
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.layer.borderWidth = 0.5
        tv.layer.cornerRadius = 8
        return tv
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "SolutionSDK Demo"
        view.backgroundColor = .white
        setupUI()
        requestCameraPermission()
    }

    private func setupUI() {
        let resultLabel = UILabel()
        resultLabel.text = "Result:"
        resultLabel.font = .systemFont(ofSize: 15, weight: .medium)

        view.addSubview(urlTextField)
        view.addSubview(scanButton)
        view.addSubview(startButton)
        view.addSubview(resultLabel)
        view.addSubview(resultTextView)

        scanButton.addTarget(self, action: #selector(scanQrCode), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startBtnClick), for: .touchUpInside)

        urlTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }

        scanButton.snp.makeConstraints { make in
            make.top.equalTo(urlTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }

        startButton.snp.makeConstraints { make in
            make.top.equalTo(scanButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }

        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(startButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
        }

        resultTextView.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }

    @objc private func scanQrCode() {
        let scanner = QRCodeScanViewController()
        scanner.foundUrl = { [weak self] url in
            self?.urlTextField.text = url
        }
        navigationController?.pushViewController(scanner, animated: true)
    }

    @objc private func startBtnClick() {
        view.endEditing(true)

        guard let urlString = urlTextField.text, !urlString.isEmpty else {
            resultTextView.text = "Please scan or paste a solution URL"
            return
        }

        guard URL(string: urlString) != nil else {
            resultTextView.text = "Invalid URL"
            return
        }

        resultTextView.text = "Starting..."

        SolutionCenter.shared.setDarkThemeType(.FOLLOW_SYSTEM)

        SolutionCenter.shared.register(listener: SLListener(end: { [weak self] result in
            let text = """
            code: \(result.code)
            signatureId: \(result.signatureId ?? "nil")
            finishRedirectUrl: \(result.finishRedirectUrl ?? "nil")
            extraInfo: \(result.extraInfo ?? [:])
            terminated: \(result.terminated)
            """
            self?.resultTextView.text = text

            guard !result.terminated else { return }

            if result.code == "FINISH" {
                if let extraInfo = result.extraInfo,
                   let submissionStatus = extraInfo["submissionStatus"] as? String,
                   submissionStatus == "SUBMITTED" {
                    print("KYC data submitted successfully.")
                }
            }
        }))

        SolutionCenter.shared.start(with: urlString)
    }

    private func requestCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { _ in }
        }
    }

}
