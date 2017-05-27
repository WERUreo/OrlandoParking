//
//  MainViewController.swift
//  OrlandoParking
//
//  Created by Keli'i Martin on 4/19/17.
//  Copyright © 2017 WERUreo. All rights reserved.
//

import UIKit
import OPRequestService

class MainViewController: UIViewController
{
    struct EventSection
    {
        var date: String
        var events: [OPEvent]
    }

    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var tableView: UITableView!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var events = [OPEvent]()
    var eventSections = [EventSection]()

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Lifecycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.configureTableView()
    }

    ////////////////////////////////////////////////////////////

    func configureTableView()
    {

    }
}

////////////////////////////////////////////////////////////
// MARK: - UITableViewDelegate, UITableViewDataSource
////////////////////////////////////////////////////////////

extension MainViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    ////////////////////////////////////////////////////////////

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }

    ////////////////////////////////////////////////////////////

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        return UITableViewCell()
    }
}
