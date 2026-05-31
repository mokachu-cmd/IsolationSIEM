**Using Isolation Forest to improve SIEM Anomaly Detection**

Isolation Forest is an anomaly detection algorithm designed to spot outliers on given data after being trained. While well known and often used, Isolation Forest suffers from the following issues:

- Lack of Real-Time data input capabilities
- Lack of Anomaly Context Awareness
- Lack of ability to autonomously adapt to changing environments, threat vectors, and threat techniques
- Requirements for significant periods of pre-existing data in order to train the algorithm
- Constant training required for changed/adaptive/fluid internal environments

These issues make a good algorithm such as Isolation Forest incredibly limited for modern applications and internal organizational environments.

Devices are consistently being changed, attackers consistently find new ways to infiltrate systems and cover their tracks, and seasonal organizational changed are also common (An example would be oranizations that allow for increased Remote Work situations for all employees over a festive period. This would see a spike in remote connections to the internal environment and could potentially be flagged as potential DDoS attack.)

Machine Learning and Artificial Intelligence are required to take Isolation Forest from it's current state to a modern, efficient, and useful anomaly detection system.

For this inital trial, Isolation Forest will be fed real-time data from a SIEM running locally on a Windows machine and tracking activity and connections for that specific machine. While this is an incredibly limited scenario, it is meant to serve as a foundation before a more comprehensive Proof-Of-Concept is created. Once that is done, it can then be expanded into a more functioninal project/product.

Please see OUTLINE.md for more details regarding the flow from start to end for this specific scenario.