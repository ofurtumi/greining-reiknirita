import requests
import random

url = "http://64.225.108.43:5000/play" 
values = [0.2, 0.5, 0.3]
game_id = 0
n_slots = len(values)
tests = 10
outputs = [0] * n_slots
runs = [0] * n_slots


def fetch(i):
    if random.uniform(0, 1) <= values[i]:
        return 1
    return 0

def probabilities(values, runs):
    print(f'Estimated probability for slots')
    for (i, score) in enumerate(values):
        print(f'{i}: {(score/runs[i]):.3f}')

def explore(slots, tests, runs):
    for i in range(len(slots)):
        for _ in range(tests):
            outputs[i] += fetch(i)
            # PARAMS = {"gameid": game_id, "slotid": i, "playerid": 'fe38'} 
            # outputs[i] += int(requests.get(url, params = PARAMS).json()["winnings"]) 
        runs[i] += tests

def exploit(slots, runs):
    max_machine = slots.index(max(slots)) 
    exploit_sum = 0
    exploit_range = 1000 - sum(runs)
    for _ in range(exploit_range):
        exploit_sum += fetch(max_machine)
        # PARAMS = {"gameid": game_id, "slotid": max_machine, "playerid": 'fe38'}
        # requests.get(url, params = PARAMS)
    runs[max_machine] += exploit_range
    slots[max_machine] += exploit_sum

def main():
    global total_tests
    explore(outputs, tests, runs)
    probabilities(outputs, runs)
    exploit(outputs, runs)
    probabilities(outputs, runs)

main()
