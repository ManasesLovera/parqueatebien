import React from 'react';
import { RouterProvider, createBrowserRouter } from 'react-router-dom';
import Login from './login.js'
import Backoffice from './Backoffice'; 
import {ResultadoConsulta} from './ResultadoConsulta.js'
import {ResultadoError} from './resulterror.js'
import {Home} from './home.js'

const router = createBrowserRouter([
    {
        path: '/',
        element: <Home />
    },
    {
        path: '/login',
        element: <Login />
    },
    {
        path: '/backoffice',
        element: <Backoffice />
    },
    {
        path: '/resultado',
        element: <ResultadoConsulta />
    },
    {
        path: '/resultadoError',
        element: <ResultadoError />
    }
]);

function App() {
  return <RouterProvider router={router} />
}

export default App;