import ConfigParser
import sys

# XX this fails if the base image is not one of these
# distros
distro_cmd = {'package_manager':
              {'fedora':'yum',
               'ubuntu':'apt-get',
               'debian':'apt-get',
               }
          }

def generate(conf_file):
    config = ConfigParser.SafeConfigParser()
    config.read(conf_file)

    distro = config.get('baseimage', 'name')
    tag = config.get('baseimage', 'tag')

    dockerfile = \
'''
FROM {0}:{1}
RUN {2} -y install {3}
'''.format(distro, tag,
               distro_cmd['package_manager'][distro],
               ' '.join(config.get('config', 'packages').split())
               )
    return dockerfile

if __name__ == '__main__':
    print(generate(sys.argv[1]))
