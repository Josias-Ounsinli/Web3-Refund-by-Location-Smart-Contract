from setuptools import setup, find_packages

with open('README.md') as readme_file:
    readme = readme_file.read()

requirements = []

test_requirements = ['pytest>=3', ]

setup(
    author="Josias-Ounsinli",
    email="josias.ouns.djossou.com",
    python_requires='>=3.6',
    classifiers=[
        'Natural Language :: English',
    ],
    description="Web3: Refund by Location Smart Contract",
    install_requires=,
    long_description=readme,
    include_package_data=True,
    keywords='tests',
    name='tests',
    packages=find_packages(include=[]),
    test_suite='tests',
    tests_require=test_requirements,
    url='https://github.com/Josias-Ounsinli/Web3-Refund-by-Location-Smart-Contract.git',
    version='0.1.0',
    zip_safe=False,
)