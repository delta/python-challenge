import random, string, re
flag = "REGEXISPOWERFUL"
rand_str_len = 10000
vowels = ['a', 'e', 'i', 'o', 'u']
fragment_regex = "[^aeiou][aeiou]{2}[A-Z][0-9]{3}[^0-9]"
fragment_length = 6

def generate_random_string():
    letters = string.ascii_lowercase + string.ascii_uppercase + string.digits
    rand_string = ''.join(random.choice(letters) for i in range(rand_str_len))
    return rand_string

def check_index(ind, rand_str):
    if ind > 0 and rand_str[ind - 1] in vowels:
        return False
    if ind < rand_str_len - 1 and rand_str[ind + 1] in string.digits:
        return False
    return True

def inject_flag(rand_str):
    section_size = rand_str_len // len(flag)
    for i in range(len(flag)):
        fragment = ''.join(random.choice(vowels) for i in range(2)) + flag[i] +
        ''.join(random.choice(string.digits) for i in range(3)) index =
        random.randrange(i * section_size, (i + 1) * section_size -
                fragment_length)

        while not check_index(index, rand_str):
            index = random.randrange(i * section_size, (i + 1) * section_size -
                    fragment_length)

        rand_str = rand_str[:index] + fragment + rand_str[index + 1:]
    return rand_str

def test(rand_str):
    m = re.findall(fragment_regex, rs)
    extracted_flag = ''.join([x[3] for x in m])
    assert extracted_flag == flag, "Regex failed"

if __name__ == '__main__':
    rs = generate_random_string()
    rs = inject_flag(rs)
    print(rs)
    test(rs)
