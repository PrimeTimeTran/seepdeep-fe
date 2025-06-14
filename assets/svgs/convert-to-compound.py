import os
from svgpathtools import svg2paths, Path
from lxml import etree

def convert_to_compound_path(file_path, output_dir):
    try:
        paths, attributes = svg2paths(file_path)
        compound_path = Path(*paths)
        new_svg = etree.Element("svg", xmlns="http://www.w3.org/2000/svg")
        path_element = etree.SubElement(new_svg, "path", d=compound_path.d())
        filename = os.path.basename(file_path)
        output_file_path = os.path.join(output_dir, filename)
        with open(output_file_path, "wb") as output_file:
            output_file.write(etree.tostring(new_svg, pretty_print=True))
    except Exception as e:
        print(f"Failed to process {file_path}: {e}")

def process_folder(folder_path, output_dir):
    if not os.path.isdir(folder_path):
        print(f"The folder path {folder_path} does not exist or is not a directory.")
        return
    os.makedirs(output_dir, exist_ok=True)
    for filename in os.listdir(folder_path):
        if filename.endswith(".svg"):
            file_path = os.path.join(folder_path, filename)
            convert_to_compound_path(file_path, output_dir)
            print(f"Processed: {file_path}")

if __name__ == "__main__":
    folder_path = "./assets/parsing"
    output_dir =  "./assets/parsing/refined/"
    process_folder(folder_path, output_dir)
