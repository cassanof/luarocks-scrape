import os
import pathlib
import datasets


file_path = pathlib.Path(__file__).parent.absolute().joinpath('unpacked')

lua_files = list(file_path.rglob('*.lua'))

dataset_dict = {
    "id": [],
    "content": []
}

num_not_processed = 0
for i, lua_file in enumerate(lua_files):
    if os.path.isdir(lua_file):
        num_not_processed += 1
        continue
    try:
        with open(lua_file, 'r', encoding='utf-8') as f:
            content = f.read()
            dataset_dict['id'].append(str(i - num_not_processed))
            dataset_dict['content'].append(content)
    except UnicodeDecodeError:
        print(f'Error: {lua_file}')
        num_not_processed += 1

print(f"Total files in the dataset: {len(dataset_dict['id'])}")

# make sure ids are continuous
for i, e_id in enumerate(dataset_dict['id']):
    assert i == int(e_id)

dataset = datasets.Dataset.from_dict(dataset_dict)
dataset.push_to_hub("luarocks")
