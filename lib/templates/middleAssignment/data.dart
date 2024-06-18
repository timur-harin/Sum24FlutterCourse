class HistoryData {
  int rating;
  int stages;
  int totalTime;
  


  HistoryData({
    required this.rating,
    required this.stages,
    required this.totalTime,
    
  });

  HistoryData.fromJson(Map <String, dynamic> json) 
  : rating = json['rating'], 
    stages = json['stages'], 
    totalTime = json['totalTime'];
    


  Map<String, dynamic> toJson() => {
    'rating' : rating,
    'stages' : stages,
    'totalTime' : totalTime,
    
  };
  
}

