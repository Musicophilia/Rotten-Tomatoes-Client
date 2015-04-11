//
//  MoviesViewController.swift
//  tomatoes
//
//  Created by Lisa Wang on 4/10/15.
//  Copyright (c) 2015 Lisa Wang. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var movies: [NSDictionary]! = [NSDictionary]()

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let YourApiKey = "ey5qkuppqbbd2rxsa4u4umzw"
        let url = NSURL(string: ("http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey))
        let request = NSMutableURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.movies = dictionary["movies"] as [NSDictionary]
            NSLog("got response: %@", self.movies)
            self.tableView.reloadData()
            
        })
        
        tableView.dataSource = self
        tableView.delegate = self


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("My Movie Cell", forIndexPath: indexPath) as MovieCell
        var movie = movies[indexPath.row]
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        var posterUrl = movie.valueForKeyPath("posters.thumbnail") as? String
        let url = NSURL(string: posterUrl!)
        cell.posterView.setImageWithURL(url!)
        
        
    
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
