"""
Custom Robot Framework library for automation exercise project.
This library provides additional keywords for common automation tasks.
"""

from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn
import json
import csv
import os


class AutomationExerciseLibrary:
    """Custom library for Automation Exercise testing."""
    
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    
    def __init__(self):
        self.builtin = BuiltIn()
    
    @keyword
    def load_test_data_from_json(self, file_path):
        """Load test data from JSON file.
        
        Args:
            file_path: Path to the JSON file
            
        Returns:
            Parsed JSON data as dictionary
        """
        try:
            with open(file_path, 'r') as file:
                data = json.load(file)
            return data
        except Exception as e:
            raise Exception(f"Failed to load JSON data from {file_path}: {str(e)}")
    
    @keyword
    def load_test_data_from_csv(self, file_path):
        """Load test data from CSV file.
        
        Args:
            file_path: Path to the CSV file
            
        Returns:
            List of dictionaries with CSV data
        """
        try:
            data = []
            with open(file_path, 'r') as file:
                csv_reader = csv.DictReader(file)
                for row in csv_reader:
                    data.append(row)
            return data
        except Exception as e:
            raise Exception(f"Failed to load CSV data from {file_path}: {str(e)}")
    
    @keyword
    def generate_unique_email(self, base_email="test@example.com"):
        """Generate unique email address for testing.
        
        Args:
            base_email: Base email address to modify
            
        Returns:
            Unique email address
        """
        import time
        import random
        
        timestamp = str(int(time.time()))
        random_num = str(random.randint(100, 999))
        
        if "@" in base_email:
            local, domain = base_email.split("@", 1)
            unique_email = f"{local}_{timestamp}_{random_num}@{domain}"
        else:
            unique_email = f"{base_email}_{timestamp}_{random_num}"
            
        return unique_email
    
    @keyword 
    def create_results_directory(self, dir_name="results"):
        """Create results directory if it doesn't exist.
        
        Args:
            dir_name: Name of the directory to create
        """
        try:
            os.makedirs(dir_name, exist_ok=True)
            self.builtin.log(f"Results directory created: {dir_name}")
        except Exception as e:
            raise Exception(f"Failed to create directory {dir_name}: {str(e)}")