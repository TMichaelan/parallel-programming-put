import random

def generate_numbers(n, lower_limit, upper_limit):
    return [random.randint(lower_limit, upper_limit) for _ in range(n)]

def write_to_file(filename, numbers):
    with open(filename, 'w') as f:
        for num in numbers:
            f.write(str(num) + '\n')


num_range = [100, 300, 500, 1000, 3000, 5000, 10000, 30000, 50000, 100000, 300000, 500000, 1000000,10000000]

for number in num_range:

    numbers = generate_numbers(number, 1, 10000000)

    write_to_file(f'data/{number}.txt', numbers)
