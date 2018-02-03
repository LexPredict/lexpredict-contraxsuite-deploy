# Imports
import csv
import pkg_resources

OUTPUT_KEYS = ["Name",
               "Version",
               "Summary",
               "License",
               "Author",
               "Author-email",
               "Home-page"]

if __name__ == "__main__":
    # Setup CSV output
    csv_file = open('licenses.csv', 'w')
    csv_writer = csv.writer(csv_file)
    csv_writer.writerow([key for key in OUTPUT_KEYS])

    # Open file and read lines
    with open("base/python-requirements.txt", "r") as input_file:
        # Iterate through all lines
        for line in input_file.readlines():
            # Setup package dictionary
            package_row =  dict([(key, None) for key in OUTPUT_KEYS])
            
            # Tokenize package name
            package_row["Name"] = line.split("=")[0].strip()
            try:
                package_info = pkg_resources.get_distribution(package_row["Name"])
                package_metadata = package_info._get_metadata(package_info.PKG_INFO)

                for metadata_line in package_metadata:
                    if ":" in metadata_line:
                        key, value = metadata_line.split(":", 1)
                        if key in OUTPUT_KEYS:
                            package_row[key] = value.strip()
            except Exception as e:
                print((package_row["name"], e))
                pass

            csv_writer.writerow([package_row[key] for key in OUTPUT_KEYS])

    # CLose CSV file
    csv_file.close()
