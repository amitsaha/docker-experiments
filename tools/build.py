import sys
import argparse
from docker import Client

def build(build_dir, tag):
    c = Client(base_url='unix://var/run/docker.sock')
    for line in c.build(build_dir):
        print line

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('dockerfile_dir',
                        help='Directory containing the Dockerfile'
                        )
    parser.add_argument('tag',
                        help='Docker image tag'
                        )
    args = parser.parse_args()
    build(args.dockerfile_dir, args.tag)
