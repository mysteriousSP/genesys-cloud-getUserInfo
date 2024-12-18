# genesys-cloud-getUserInfo

## Overview
This project is a Python-based tool designed to interact with the Genesys platform. Proper setup of a virtual environment is necessary to ensure all dependencies are correctly installed and isolated.

---

## Getting Started

### Prerequisites
- Python 3.x installed on your machine.
- Basic understanding of navigating the command line.

---

### Instructions

#### Step 1: Clone the Repository
1. **Open Command Prompt**.
2. **Navigate to the Directory Where You Want to Clone the Project**:
   ```
   cd C:\path\to\your\desired\directory
   ```
3. **Clone the Repository**:
   ```
   git clone https://github.com/mysteriousSP/genesys-cloud-getUserInfo.git
   ```
4. **Navigate to the Project Directory**:
   ```
   cd genesys-cloud-getUserInfo
   ```

#### Step 2: Modify Configuration Variables
Before running the script, you need to modify some variables in the script to match your environment:
   ```
   $clientId = 'clientID-goes-here'
   $clientSecret = 'clientSecret-Goes-Here'
   $environment = 'usw2.pure.cloud'
   ```
   Ensure these variables are updated with your actual Genesys credentials and environment.

#### Step 3: Create a Virtual Environment
1. **Open Command Prompt** (if not already open).
2. **Navigate to Your Project Directory**:
   ```
   cd C:\path\to\genesys-cloud-getUserInfo
   ```
3. **Create a New Virtual Environment**:
   ```
   python -m venv venv
   ```
   This command creates a new folder named `venv` in your project directory containing the isolated Python environment.

4. **Activate the Virtual Environment**:
   ```
   venv\Scripts\activate
   ```
   After activation, your command prompt will change to indicate that the virtual environment is active (e.g., it will show `(venv)` before the path).

#### Step 4: Install Required Packages
With the virtual environment active, run:
```
   pip install requests
```

#### Step 5: Run the Python Script
Execute the script:
```
   python C:\path\to\genesys-cloud-getUserInfo\getUserInfo.py
```

#### Step 6: Deactivate the Virtual Environment
To deactivate the virtual environment at any time, run:
``` 
   deactivate
```

---

### Alternative: Using PowerShell
If you cannot use WSL (Windows Subsystem for Linux) or create a virtual environment, a PowerShell equivalent script is provided. There is no need to create a virtual environment for PowerShell scripts.

---

## Additional Notes
- Ensure you have the necessary permissions to execute scripts on your machine.
- For further customization or troubleshooting, refer to the project's documentation or reach out to the development team.

---

## License
This project is licensed under the GPL-3.0 license.

---


## Contact
For issues or questions, please open an issue on GitHub or contact the repository maintainer directly.
