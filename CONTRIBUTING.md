# Contributing to Serverless Todo API

Thank you for your interest in contributing to the Serverless Todo API project! This document provides guidelines for contributing.

## How to Contribute

### 1. Fork the Repository

1. Fork the repository on GitHub
2. Clone your fork locally
3. Create a new branch for your feature

```bash
git clone https://github.com/your-username/aws-serverless-demo.git
cd aws-serverless-demo
git checkout -b feature/your-feature-name
```

### 2. Make Your Changes

- Follow the existing code style and conventions
- Add tests for new functionality
- Update documentation as needed
- Ensure all tests pass

### 3. Test Your Changes

```bash
# Format and lint your code
make format
make lint

# Test the API (if applicable)
make test API_URL=https://your-api-url/dev

# Plan Terraform changes
make plan
```

### 4. Commit Your Changes

Use conventional commit messages:

```bash
git commit -m "feat: add user authentication"
git commit -m "fix: resolve DynamoDB connection issue"
git commit -m "docs: update API documentation"
```

### 5. Push and Create a Pull Request

```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub with a clear description of your changes.

## Development Guidelines

### Code Style

- **Python**: Follow PEP 8 guidelines
- **Terraform**: Use consistent formatting
- **Documentation**: Use clear, concise language

### Testing

- Test all new functionality
- Ensure existing functionality still works
- Test error scenarios
- Verify API endpoints

### Documentation

- Update README.md if needed
- Add comments to complex code
- Update relevant documentation files

## Types of Contributions

### Bug Reports

When reporting bugs, please include:

1. Clear description of the issue
2. Steps to reproduce
3. Expected vs actual behavior
4. Environment details (OS, Python version, etc.)

### Feature Requests

When requesting features, please include:

1. Clear description of the feature
2. Use case and benefits
3. Implementation suggestions (if any)

### Code Contributions

- Bug fixes
- New features
- Documentation improvements
- Performance optimizations

## Getting Help

If you need help with your contribution:

1. Check the [documentation](docs/)
2. Open a [GitHub Issue](https://github.com/bansikah22/aws-serverless-demo/issues)
3. Start a [Discussion](https://github.com/bansikah22/aws-serverless-demo/discussions)

## Code of Conduct

- Be respectful and inclusive
- Focus on the code and technical discussions
- Help others learn and grow

## License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0.

Thank you for contributing! 🚀
