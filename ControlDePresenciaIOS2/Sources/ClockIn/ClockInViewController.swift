

import UIKit
import Firebase
import Kingfisher
import CoreLocation
import MapKit
//Output del Presenter
protocol ClockInPresenterOutputProtocol {
    func reloadInformationInView()
    func updateTime()
    func updateWeather(data:Welcome)
}

class ClockInViewController: BaseView<ClockInPresenterInputProtocol> {
    //MARK: - Variables globales
    var user = Auth.auth().currentUser
    var clockedIn: Bool = false
    var currentTime : String = ""
    var currentDay : String = ""
    var clockInTime : String = ""
    var clockOutTime: String = ""
    var defaults = UserDefaults.standard
    var ref: DatabaseReference! = Database.database().reference()
    var esGerente :Bool = false
    var manager : String = ""
    var tickCount = 0
    let totalClicks = 60
    var progressIncrement:Float = 0.0
    var hardReload = false
    //MARK: - Wheather app
    let locationManager = CLLocationManager()
    var ciudad:String = "Madrid"
    //MARK: - DataModel
    var timeRecords = [TimeRecord]()
    var thisUserData: UserRecord?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var logoutBTN: UIBarButtonItem!
    @IBOutlet weak var taskBTN: UIBarButtonItem!
    @IBOutlet weak var userBTN: UIBarButtonItem!
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var fichaPersonaStack: UIStackView!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var displayNameLBL: UILabel!
    @IBOutlet weak var stackHoraEntrada: UIStackView!
    @IBOutlet weak var textoHoraEntradaLBL: UILabel!
    @IBOutlet weak var horaEntradaLBL: UILabel!
    @IBOutlet weak var clockInBTN: UIButton!
    @IBOutlet weak var stackHoraSalida: UIStackView!
    @IBOutlet weak var textoHoraSalidaLBL: UILabel!
    @IBOutlet weak var horaSalidaVal: UILabel!
    @IBOutlet weak var clockOutBTN: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherImage: UIStackView!
    @IBOutlet weak var progressBar: UIProgressView!
    //MARK: - IBActions
    
    @IBOutlet weak var showLogoutAction: UIBarButtonItem!
    @IBAction func showTasksActions(_ sender: UIBarButtonItem) {
        hardReload = true
        self.presenter?.showTasksList()
        debugPrint("---->Volviendo de la vista desde tareas")
    }
    @IBAction func showUsersAction(_ sender: UIBarButtonItem) {
        hardReload = true
        self.presenter?.showUsersList()
        debugPrint("---->Volviendo de la vista desde usuarioss")
    }
    @IBAction func clockInActionClick(_ sender: UIButton) {
        clockedIn = true
        clockInTime = horaActual()
        currentDay = TimeUtils.diaActual()
        debugPrint(currentDay)
        guardarPreferenciasLocales()
        configurarUI()
    }
    
    fileprivate func firebaseLogout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            // navigationController?.popViewController(animated: true)
            self.dismiss(animated: false, completion: nil)
        } catch let signOutError as NSError {
            debugPrint("Error signing out: %@", signOutError)
        }
    }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        if clockedIn {
        let alert = UIAlertController(title: K.appName,
                                      message: "Ya hizo clockin, ¿Hacer clockout antes de salir?",
                                      preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "ClockOut",
                                      style: .default,
                                      handler: { action in
                debugPrint(action)
            self.clockOutMethod()
            self.firebaseLogout()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar",
                                      style: .cancel,
                                      handler: { action in
            debugPrint(action)
        }))
        self.present(alert, animated: true)
        } else {
            self.firebaseLogout()
        }
    }
    @IBOutlet weak var clockInAction: UIButton!
    fileprivate func clockOutMethod() {
        clockedIn = false
        clockOutTime = horaActual()
        guardarTimeRecord()
        guardarPreferenciasLocales()
        configurarUI()
    }
    
    @IBAction func clockOutAction(_ sender: UIButton) {
        clockOutMethod()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        // Pedimos autorizacion para usar la ubicacion
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            locationManager.startUpdatingLocation()
        }
        // Cargamos los datos del usuario desde FirebaseRealtime
        leerDatosUsuario()
        self.tableView.delegate = self
        configurarTableView()
        leerPreferenciasLocales()
        self.presenter?.loadDataFromInteractor()
        configurarUI()
        loadProfilePicture()
       
        self.presenter?.setUpdateClock()
        //testTimer()
    }
    func horaActual() -> String {
        return TimeUtils.horaActual()
    }
    
    func leerPreferenciasLocales(){
        if let localConfig = self.presenter?.loadLocalData(){
            clockInTime = localConfig.clockIn
            clockOutTime = localConfig.clockOut
            clockedIn = localConfig.clockedIn
            currentDay = localConfig.day
        }
    }
    func guardarPreferenciasLocales(){
        self.presenter?.saveLocalData(config: LocalConfig(day: currentDay,
                                                          clockIn: clockInTime,
                                                          clockOut: clockOutTime,
                                                          clockedIn: clockedIn))
    }
    func configurarUI(){
        progressBar.progress = 0.0
        progressIncrement = 1.0 / Float(totalClicks)
        currentTime = horaActual()
        if clockedIn {
            horaEntradaLBL.text = clockInTime
            horaSalidaVal.text = currentTime
            
        } else {
            horaEntradaLBL.text = currentTime
            horaSalidaVal.text = "--:--"
        }
        clockInBTN.isEnabled = !clockedIn
        clockOutBTN.isEnabled = clockedIn
        displayNameLBL.text = user?.displayName ?? "----"
        stackHoraSalida.backgroundColor = clockedIn ? UIColor.green : nil
        stackHoraEntrada.backgroundColor = clockedIn ? nil : UIColor.green
        taskBTN.isEnabled = esGerente
        userBTN.isEnabled = esGerente
        
        imageAvatar.layer.cornerRadius = imageAvatar.frame.width/2.0
        imageAvatar.layer.borderWidth = 2.0
    }
    func configurarTableView(){
        debugPrint(#function)
        tableView.delegate  = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TimeRecordCell.defaultReuseIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: TimeRecordCell.defaultReuseIdentifier)
    }
    func loadProfilePicture(){
        let pic = user?.photoURL
        if pic != nil {
            self.imageAvatar.kf.setImage(with: pic)
        }
    }
    func leerDatosUsuario(){
        let entry = user?.email?.replacingOccurrences(of: ".",
                                                      with: "_")
        let path = "\(K.userTable)/\(entry!)"
        ref.child(path).getData(completion:  { error, snapshot in
            guard error == nil else {
                debugPrint(error!.localizedDescription)
                return;
            }
            if let userFromDB = snapshot.value as? [String:Any]{
                debugPrint("Loaded from Firebase.Realtime------------>",userFromDB)
                
                let esGerente = userFromDB["esGerente"] as? Bool ?? false
                //let estaActivado = user["estaActivado"] as? Bool ?? true
                let manager = userFromDB["manager"] as? String ?? "-"
                self.defaults.set(manager,forKey: K.managerName  )
                let displayName = userFromDB["displayName"] as? String ?? "--"
                let avatarImgURL = userFromDB["avatar"] as? String ?? ""
                self.defaults.set(displayName,forKey: K.displayName)
                self.taskBTN.isEnabled = esGerente
                self.userBTN.isEnabled = esGerente
                self.esGerente = esGerente
                self.manager = manager
                if (!avatarImgURL.isEmpty)
                    {
                    debugPrint("Cargando la imagen del avatar")
                    self.imageAvatar.kf.setImage(with:URL(string:avatarImgURL))}
                self.configurarUI()
            }
        });
        
    }
    func guardarTimeRecord(){
        let uuid = UUID().uuidString
        let userId = user?.uid
        if (TimeUtils.timeToMinutes(data: clockInTime) < 0 || TimeUtils.timeToMinutes(data: clockOutTime) < 0 ) {
            debugPrint("No se deberia producir esto, error en tiempo clocking o clockOut ", clockInTime, clockOutTime)
        } else {
        let timeRecord = TimeRecord(id: uuid,
                                    userId: userId!,
                                    day: currentDay ,
                                    clockIn: clockInTime,
                                    clockOut: clockOutTime,
                                    minutes: 0)
        
            self.presenter?.saveCurrentTimeRecord(data: timeRecord)
        }
    }
    func testTimer(){
        Timer.scheduledTimer(withTimeInterval: 100,
                             repeats: true) { timer in
            debugPrint(Date.now)
            
        }
        
    }
}


//OUTPUT del presenter
extension ClockInViewController: ClockInPresenterOutputProtocol {
    func updateWeather(data: Welcome) {
        let wheaterDescription = data.weather?.first?.weatherDescription
        if let urlUnw = data.weather?.first?.icon {
            let urlString = "https://openweathermap.org/img/wn/\(urlUnw)@2x.png"
            self.weatherIcon.kf.setImage(with:URL(string:urlString))
        }
        self.weatherLabel.text = wheaterDescription
    }
    
    func updateTime() {
        progressBar.progress += progressIncrement
        tickCount += 1
        if tickCount >= 60 {
            tickCount = 0
            progressBar.progress = 0.0
        }
        if self.clockedIn {
            self.horaSalidaVal.text = TimeUtils.horaActual()
        }
        else {
            self.horaEntradaLBL.text = TimeUtils.horaActual()
        }
    }
    
    
    func reloadInformationInView() {
        self.tableView.reloadData()
    }
}

extension ClockInViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRows()  ?? 0
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeRecordCell.defaultReuseIdentifier,
                                                 for: indexPath) as! TimeRecordCell
        if let model = self.presenter?.informationForCell(indexPath: indexPath.row){
            cell.delegate = self
            cell.setupCell(data: model)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = self.presenter?.informationForCell(indexPath: indexPath.row){
            self.presenter?.didSelectRow(data: model)
        }
    }
    
}

extension ClockInViewController: TimeRecordCellOutputProtocol {
    func editRecord(data: TimeRecord) {
        debugPrint("Estoy en el ddelegado")
        debugPrint(data)
        self.presenter?.showEditDialog(data: data)
        
    }
    

    
}

extension ClockInViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        guard let location:CLLocation = manager.location else {return}
        fetchCityAndCountry(from: location) { city, country, error in
            guard let city = city, let country = country, error == nil else {return }
            print(city + "," + country )
            self.ciudad = city
            self.presenter?.fetchData(city: city)
        }
        
    }
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
}
