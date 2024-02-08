import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import {urlConfig} from '../../config';

function MainPage() {
    const [gifts, setGifts] = useState([]);
    const navigate = useNavigate();

    useEffect(() => {
        // Task 1: Write async fetch operation
        {{insert code here}}
    }, []);

    // Task 2: Navigate to details page
    const goToDetailsPage = (productId) => {
        {{insert code here}}
    };

    // Task 3: Format timestamp
    const formatDate = (timestamp) => {
        {{insert code here}}
    };

    const getConditionClass = (condition) => {
        return condition === "New" ? "list-group-item-success" : "list-group-item-warning";
    };

    return (
        <div className="container mt-5">
            <div className="row">
                {gifts.map((gift) => (
                    <div key={gift.id} className="col-md-4 mb-4">
                        <div className="card product-card">
                            
                            // Task 4: Display gift image or placeholder
                            {{insert code here}}
                            
                            <div className="card-body">
                                
                                // Task 5: Display gift name
                                <h5 className="card-title">{{insert code here}}</h5>
                                
                                // Task 6: Display formatted date
                                <p className="card-text">{{insert code here}}</p>
                                
                                <button onClick={() => goToDetailsPage(gift.id)} className="btn btn-primary">
                                    View Details
                                </button>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}

export default MainPage;
