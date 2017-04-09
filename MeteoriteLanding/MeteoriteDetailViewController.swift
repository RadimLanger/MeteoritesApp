//
//  MeteoriteDetailViewController.swift
//  MeteoriteLanding
//
//  Created by Radim Langer on 08/04/2017.
//  Copyright © 2017 Radim Langer. All rights reserved.
//

import UIKit
import MapKit

class MeteoriteDetailViewController: UITableViewController {

    var meteorData: Meteorite!
    
    let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "detailSpace"))
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var fallLabel: UILabel!
    @IBOutlet weak var reclassLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    
    @IBOutlet var idLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var reclassLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var fallLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var yearLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var massLabelLeadingConstraint: NSLayoutConstraint!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        
        backgroundImageView.contentMode = .scaleAspectFill
        tableView.backgroundView = backgroundImageView
        addBlurEffect()

        zoomToRegion(CLLocationCoordinate2DMake(meteorData.latitude, meteorData.longitude))
        addAnnotation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fallLabel.text = meteorData.fall
        reclassLabel.text = meteorData.recclass
        nameLabel.text = meteorData.name
        idLabel.text = String(describing: meteorData.id)
        yearLabel.text = meteorData.impactDateString
        massLabel.text = meteorData.mass
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateLeadingSizeLabels()
        animateVisibilityForLabels()
    }
    
    
    private func zoomToRegion(_ coordinate: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 150000.0, 10000.0)
        mapView.setRegion(region, animated: false)
    }
    
    private func addAnnotation() {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(meteorData.latitude, meteorData.longitude)
        annotation.title = meteorData.name
        annotation.subtitle = "Lon: " + String(describing: meteorData.longitude) + " Lat: " + String(describing: meteorData.latitude)
        self.mapView.addAnnotation(annotation)
        self.mapView.selectAnnotation(annotation, animated: true)
    }
    
    private func addBlurEffect() {
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.alpha = 0.5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = tableView.bounds
        
        tableView.backgroundView?.addSubview(blurEffectView)
    }

    // MARK: animations
    
    private func animateLeadingSizeLabels() {
        
        let constraints = [idLabelLeadingConstraint, reclassLabelLeadingConstraint, fallLabelLeadingConstraint, yearLabelLeadingConstraint, massLabelLeadingConstraint]

        var delay = 0.0
        
        constraints.forEach { constraint in
            constraint?.constant = 60
            
            UIView.animate(withDuration: 0.5, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            delay = delay + 0.1
        }
    }
    
    private func animateVisibilityForLabels() {
        
        let views = [idLabel, reclassLabel, fallLabel, yearLabel, massLabel]
        
        var delay = 0.0
        
        views.forEach { view in
            
            UIView.animate(withDuration: 0.3, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .transitionCrossDissolve, animations: {
                view?.alpha = 1.0
            }, completion: nil)
            
            delay = delay + 0.1
        }
    }
    
}
