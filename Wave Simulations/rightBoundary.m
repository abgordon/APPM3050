function phantom = rightBoundary(n, alpha, beta, gamma, deltaX, u)

phantom = (2*deltaX/beta) * ( gamma - alpha * u(n)) + u(n-1);
